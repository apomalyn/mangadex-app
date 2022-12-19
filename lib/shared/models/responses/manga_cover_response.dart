import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga_cover.dart';

part 'manga_cover_response.freezed.dart';
part 'manga_cover_response.g.dart';

@freezed
class MangaCoverResponse with _$MangaCoverResponse {
  const factory MangaCoverResponse(
      {required ResponseResult result,
      required String response,
      @JsonKey(name: 'data') required MangaCover cover}) = _MangaCoverResponse;

  factory MangaCoverResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaCoverResponseFromJson(json);
}
