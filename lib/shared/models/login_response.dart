import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/token.dart';

part 'login_response.freezed.dart';

part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse(
      {required String result, required Token token}) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, Object?> json) =>
      _$LoginResponseFromJson(json);
}
