import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/api_error.dart';

part 'error_response.freezed.dart';

part 'error_response.g.dart';

@freezed
class ErrorResponse with _$ErrorResponse {
  factory ErrorResponse(
      {required String result,
      required List<ApiError> errors}) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, Object?> json) =>
      _$ErrorResponseFromJson(json);
}
