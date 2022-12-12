import 'package:logger/logger.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga.dart';
import 'package:mangadex/shared/models/responses/manga_status_response.dart';
import 'package:mangadex/shared/repositories/manga_repository.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';

class ReadingListRepository extends MangaDexApi {
  final _logger = locator<Logger>();
  final _mangaRepository = MangaRepository();

  final Map<ReadingListType, Map<String, Manga?>> _readingListMangaUuid = {
    for (var list in ReadingListType.values) list: {}
  };

  bool _readingListLoaded = false;

  Future<void> _fetchReadingListsContent([bool refresh = false]) async {
    // Fetch the reading lists only if they aren't loaded yet or if asked
    if (_readingListLoaded && !refresh) {
      return;
    }

    const endpoint = '/manga/status';
    final data = await get<MangaStatusResponse>(
        buildUrl(endpoint), MangaStatusResponse.fromJson,
        headers: await buildHeader());

    data.statuses.forEach((key, value) {
      _readingListMangaUuid.update(value, (uuids) {
        uuids.putIfAbsent(key, () => null);
        return uuids;
      });
    });

    _readingListLoaded = true;
  }

  Future<List<Manga>> getReadingList(ReadingListType list,
      [bool refresh = false]) async {
    await _fetchReadingListsContent(refresh);
    List<String> toFetch = [];

    _readingListMangaUuid[list]!.forEach((uuid, manga) {
      if (manga == null && !toFetch.contains(uuid)) {
        toFetch.add(uuid);
      }
    });

    if (toFetch.isEmpty) {
      return _readingListMangaUuid[list]!
          .values
          .map((e) => e!)
          .toList(growable: false);
    }

    List<Manga> toReturn = await _mangaRepository.getMangas(toFetch);

    // Update the list
    for (final manga in toReturn) {
      _readingListMangaUuid[list]!.update(manga.id, (value) => manga);
    }

    return toReturn;
  }
}
