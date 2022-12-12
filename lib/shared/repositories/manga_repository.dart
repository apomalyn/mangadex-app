import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/models/manga.dart';
import 'package:mangadex/shared/models/responses/manga_response.dart';
import 'package:mangadex/shared/services/mangadex_api.dart';

class MangaRepository extends MangaDexApi {
  final _logger = locator<Logger>();

  Future<List<Manga>> getMangas([List<String>? ids]) async {
    const endpoint = '/manga';
    final uri = buildUrl(endpoint, {'ids[]': ids});

    final response = await httpClient.get(uri, headers: await buildHeader());

    checkForHttpError(response);

    final data = MangaResponse.fromJson(jsonDecode(response.body));

    return data.mangas;
  }
}
