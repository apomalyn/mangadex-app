import 'package:mangadex/shared/utils/exceptions/http_exception.dart';

/// Represent the 401 http status code
class UnauthorizedException extends HttpException {
  const UnauthorizedException({required super.endpoint, super.message = ''})
      : super(statusCode: 401);

  @override
  String toString() =>
      'Unauthorized call to $endpoint. ${message.isNotEmpty ? message : ''}';
}
