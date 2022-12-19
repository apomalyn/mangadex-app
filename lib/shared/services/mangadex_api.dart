import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:logger/logger.dart';
import 'package:mangadex/locator.dart';
import 'package:mangadex/shared/models/error_response.dart';
import 'package:mangadex/shared/models/responses/login_response.dart';
import 'package:mangadex/shared/models/responses/check_response.dart';
import 'package:mangadex/shared/utils/exceptions/expired_token_exception.dart';
import 'package:mangadex/shared/utils/exceptions/unauthorized_exception.dart';
import 'package:mangadex/shared/utils/exceptions/http_exception.dart' as app;
import 'package:mangadex/shared/utils/string_extensions.dart';
import 'package:meta/meta.dart';

class MangaDexApi {
  final _logger = locator<Logger>();

  static const _apiUrl = "api.mangadex.org";

  @visibleForTesting
  static const tokenSecureKey = "tokenKey";
  @visibleForTesting
  static const refreshTokenSecureKey = "refreshTokenKey";

  @visibleForTesting
  static String expirationKey(String key) =>
      'expirationDate${key.capitalize()}';

  @protected
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final http.Client _httpClient;

  String? _token;
  DateTime? _tokenExpiration;

  MangaDexApi({http.Client? client})
      : _httpClient = client ?? RetryClient(http.Client());

  @protected
  Uri buildUrl(String endpoint, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(_apiUrl, endpoint, queryParameters);

  @protected
  Future<Map<String, String>> buildHeader() async {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };

    // Try to load the token if it's not already loaded.
    if (_token == null &&
        await _secureStorage.containsKey(key: tokenSecureKey) &&
        await _secureStorage.containsKey(key: expirationKey(tokenSecureKey))) {
      _token = await _secureStorage.read(key: tokenSecureKey);
      final date =
          await _secureStorage.read(key: expirationKey(tokenSecureKey));
      _tokenExpiration = DateTime.parse(date!);
    }

    if (_tokenExpiration != null &&
        _tokenExpiration!.isBefore(DateTime.now())) {
      try {
        await _refreshToken();
      } on ExpiredTokenException {
        _logger.w('Refresh token expired.');
      }
    }

    if (_token != null) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $_token');
    }

    return headers;
  }

  @protected
  Future<T> get<T>(
      Uri url, T Function(Map<String, dynamic>) fromJsonConstructor,
      {Map<String, String>? headers}) async {
    final response =
        await _httpClient.get(url, headers: headers ?? await buildHeader());

    checkForHttpError(response);

    return fromJsonConstructor(jsonDecode(response.body));
  }

  @protected
  Future<T> post<T>(
      Uri url, T Function(Map<String, dynamic>) fromJsonConstructor,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      Function(http.Response)? checkResponse}) async {
    final response = await _httpClient.post(url,
        headers: headers ?? await buildHeader(),
        body: body != null ? jsonEncode(body) : null);

    checkForHttpError(response);
    if (checkResponse != null) {
      checkResponse(response);
    }

    return fromJsonConstructor(jsonDecode(response.body));
  }

  Future<void> login(
      {String username = '',
      String email = '',
      required String password}) async {
    const endpoint = '/auth/login';
    final data = await post<LoginResponse>(
        buildUrl(endpoint), LoginResponse.fromJson,
        headers: await buildHeader(),
        body: {'username': username, 'email': email, 'password': password},
        checkResponse: (http.Response response) {
      if (response.statusCode == HttpStatus.unauthorized) {
        throw const UnauthorizedException(
            endpoint: endpoint, message: 'Invalid credentials');
      }
    });
    _saveTokens(data.token.session, data.token.refresh);
  }

  Future<bool> silentLogin() async {
    if (!await _secureStorage.containsKey(key: tokenSecureKey)) {
      return false;
    }

    if (!await _checkToken()) {
      _logger.i("checkToken passed");
      try {
        await _refreshToken();
      } on app.HttpException {
        _clearStorage();

        return false;
      }
    }

    return true;
  }

  Future<bool> _checkToken() async {
    const endpoint = '/auth/check';
    final data = await get<CheckResponse>(
        buildUrl(endpoint), CheckResponse.fromJson,
        headers: await buildHeader());

    return data.isAuthenticated;
  }

  Future<void> _refreshToken() async {
    if (await _secureStorage.containsKey(
        key: expirationKey(refreshTokenSecureKey))) {
      final tokenExpirationDate = DateTime.parse((await _secureStorage.read(
          key: expirationKey(refreshTokenSecureKey)))!);

      if (tokenExpirationDate.isBefore(DateTime.now())) {
        _clearStorage();
        throw const ExpiredTokenException();
      }
    }
    const endpoint = '/auth/refresh';
    final refreshToken = await _secureStorage.read(key: refreshTokenSecureKey);
    final data = await post<LoginResponse>(
        buildUrl(endpoint), LoginResponse.fromJson,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},// DO NOT USE buildHeader to avoid loop
        body: {'token': refreshToken}, checkResponse: (http.Response response) {
      if (response.statusCode == HttpStatus.unauthorized) {
        throw const UnauthorizedException(
            endpoint: endpoint, message: 'Invalid credentials');
      }
    });
    _saveTokens(data.token.session, data.token.refresh);
  }

  Future<void> logout() async {
    const endpoint = '/auth/logout';
    final response = await _httpClient.post(buildUrl(endpoint),
        headers: await buildHeader());

    // Clean up storage
    _clearStorage();

    checkForHttpError(response);
  }

  @protected
  void checkForHttpError(http.Response response) {
    if (response.statusCode >= HttpStatus.badRequest) {
      // Handle any other error
      final error = ErrorResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);

      throw app.HttpException(
          endpoint: response.request!.url.path,
          statusCode: response.statusCode,
          message: jsonEncode(error.errors));
    }
  }

  Future<void> _clearStorage() async {
    _secureStorage.delete(key: tokenSecureKey);
    _secureStorage.delete(key: expirationKey(tokenSecureKey));
    _secureStorage.delete(key: refreshTokenSecureKey);
    _secureStorage.delete(key: expirationKey(refreshTokenSecureKey));
    _token = null;
    _tokenExpiration = null;
  }

  Future<void> _saveTokens(String token, String? refreshToken) async {
    final date = DateTime.now();
    _tokenExpiration = date.add(const Duration(minutes: 15));
    _token = token;

    _secureStorage.write(key: tokenSecureKey, value: token);
    _secureStorage.write(
        key: expirationKey(tokenSecureKey),
        value: _tokenExpiration!.toIso8601String());
    _secureStorage.write(key: refreshTokenSecureKey, value: refreshToken);
    _secureStorage.write(
        key: expirationKey(refreshTokenSecureKey),
        value: date.add(const Duration(days: 30)).toIso8601String());
  }
}
