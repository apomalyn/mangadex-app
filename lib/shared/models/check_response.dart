import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_response.freezed.dart';
part 'check_response.g.dart';

@freezed
class CheckResponse with _$CheckResponse {
  const factory CheckResponse(
      {required String result,
        required bool isAuthenticated,
        @Default([]) List<String> roles,
        @Default([]) List<String> permissions}) = _CheckResponse;

  factory CheckResponse.fromJson(Map<String, Object?> json) => _$CheckResponseFromJson(json);
}