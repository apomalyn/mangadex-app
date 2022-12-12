import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga.dart';

part 'manga_response.freezed.dart';

part 'manga_response.g.dart';


@freezed
class MangaResponse with _$MangaResponse {
  const factory MangaResponse(
      {required ResponseResult result, required String response, @JsonKey(name: 'data') required List<
          Manga> mangas}) = _MangaResponse;

  factory MangaResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaResponseFromJson(json);
}
