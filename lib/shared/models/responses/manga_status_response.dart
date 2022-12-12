import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';

part 'manga_status_response.freezed.dart';
part 'manga_status_response.g.dart';

@freezed
class MangaStatusResponse with _$MangaStatusResponse {
  const factory MangaStatusResponse(
          {required ResponseResult result,
          required Map<String, ReadingListType> statuses}) =
      _MangaStatusResponse;

  factory MangaStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaStatusResponseFromJson(json);
}
