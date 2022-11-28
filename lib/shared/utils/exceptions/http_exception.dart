class HttpException implements Exception {
  final int statusCode;
  final String endpoint;
  final String message;

  const HttpException(
      {required this.statusCode, required this.endpoint, this.message = ''});

  @override
  String toString() =>
      'Http Exception - endpoint: $endpoint \ncode: $statusCode ${message.isNotEmpty ? '\nMessage: $message' : ''}';
}
