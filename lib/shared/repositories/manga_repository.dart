import 'package:logger/logger.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga.dart';
import 'package:mangadex/shared/models/manga_cover.dart';
import 'package:mangadex/shared/models/responses/manga_cover_response.dart';
import 'package:mangadex/shared/models/responses/manga_response.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';

class MangaRepository extends MangaDexApi {
  final _logger = locator<Logger>();

  Future<List<Manga>> getMangas(
      [List<String>? ids, bool includeCoverArt = true]) async {
    const endpoint = '/manga';
    final uri = buildUrl(endpoint,
        {'ids[]': ids, 'includes[]': includeCoverArt ? 'cover_art' : null});

    final data = await get<MangaResponse>(uri, MangaResponse.fromJson,
        headers: await buildHeader());

    return data.mangas;
  }

  Future<MangaCover> getCover(Manga manga) async {
    const endpoint = '/manga';
    final uri = buildUrl(endpoint, {
      'mangaOrCoverId': manga.relationships
          .firstWhere(
              (element) => element.type == MangaRelationshipType.coverArt)
          .id
    });

    final data = await get<MangaCoverResponse>(uri, MangaCoverResponse.fromJson,
        headers: await buildHeader());

    return data.cover;
  }

  /// Build the cover url.
  String getCoverUrl(Manga manga,
      [CoverSize size = CoverSize.full, MangaCoverAttributes? attributes]) {
    // Check if we don't already have the cover
    final relationship = manga.relationships.firstWhere(
            (element) => element.type == MangaRelationshipType.coverArt);

    if(attributes == null && relationship.attributes != null) {
      attributes = relationship.attributes;
    } else {
      throw Exception("Cover attributes not found, please call getCover first");
    }

    final coverSize = size != CoverSize.full ? ".${size.size}.jpg" : "";

    return "https://uploads.mangadex.org/covers/${manga.id}/${attributes!.fileName}$coverSize";
  }
}
