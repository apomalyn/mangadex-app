import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mangadex/shared/models/error_response.dart';
import 'package:mangadex/shared/models/login_response.dart';
import 'package:mangadex/shared/models/check_response.dart';
import 'package:mangadex/shared/utils/exceptions/unauthorized_exception.dart';
import 'package:mangadex/shared/utils/exceptions/http_exception.dart' as app;
import 'package:meta/meta.dart';

class MangaDexApi {
  static const _apiUrl = "api.mangadex.org";

  @visibleForTesting
  static const tokenSecureKey = "tokenKey";
  @visibleForTesting
  static const refreshTokenSecureKey = "refreshTokenKey";

  @protected
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @protected
  final http.Client _httpClient;

  String? _token;

  MangaDexApi({http.Client? client})
      : _httpClient = client ?? RetryClient(http.Client());

  @protected
  Uri buildUrl(String endpoint) => Uri.https(_apiUrl, endpoint);

  @protected
  Future<Map<String, String>> buildHeader() async {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    };

    // Try to load the token if it's not already loaded.
    if (_token == null &&
        await _secureStorage.containsKey(key: tokenSecureKey)) {
      _token = await _secureStorage.read(key: tokenSecureKey);
    }

    if (_token != null) {
      headers.putIfAbsent(
          HttpHeaders.authorizationHeader, () => 'Bearer $_token');
    }

    return headers;
  }

  Future<void> login(
      {String username = '',
      String email = '',
      required String password}) async {
    const endpoint = '/auth/login';
    final response = await _httpClient.post(buildUrl(endpoint),
        headers: await buildHeader(),
        body: {'username': username, 'email': email, 'password': password});

    // Handle logging error
    if (response.statusCode == HttpStatus.unauthorized) {
      throw const UnauthorizedException(
          endpoint: endpoint, message: 'Invalid credentials');
    }
    checkForHttpError(response);

    final data = LoginResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);

    _secureStorage.write(key: tokenSecureKey, value: data.token.session);
    _secureStorage.write(key: refreshTokenSecureKey, value: data.token.refresh);
    _token = data.token.session;
  }

  Future<bool> silentLogin() async {
    if (!await _secureStorage.containsKey(key: tokenSecureKey)) {
      return false;
    }

    if (!await _checkToken()) {
      try {
        await _refreshToken();
      } on app.HttpException catch (exception) {
        // Clean up storage
        _secureStorage.delete(key: tokenSecureKey);
        _secureStorage.delete(key: refreshTokenSecureKey);

        return false;
      }
    }

    return true;
  }

  Future<bool> _checkToken() async {
    const endpoint = '/auth/check';
    final response =
        await _httpClient.get(buildUrl(endpoint), headers: await buildHeader());

    checkForHttpError(response);

    final data = CheckResponse.fromJson(jsonDecode(response.body));

    return data.isAuthenticated;
  }

  Future<void> _refreshToken() async {
    const endpoint = '/auth/refresh';
    final refreshToken = await _secureStorage.read(key: refreshTokenSecureKey);
    final response = await _httpClient.post(buildUrl(endpoint),
        headers: await buildHeader(), body: {'token': refreshToken});

    if (response.statusCode == HttpStatus.unauthorized) {
      throw const UnauthorizedException(
          endpoint: endpoint, message: 'Invalid credentials');
    }
    checkForHttpError(response);

    final data = LoginResponse.fromJson(jsonDecode(response.body));

    _secureStorage.write(key: tokenSecureKey, value: data.token.session);
    _secureStorage.write(key: refreshTokenSecureKey, value: data.token.refresh);
    _token = data.token.session;
  }

  Future<void> logout() async {
    const endpoint = '/auth/logout';
    final response = await _httpClient.post(buildUrl(endpoint),
        headers: await buildHeader());

    // Clean up storage
    _secureStorage.delete(key: tokenSecureKey);
    _secureStorage.delete(key: refreshTokenSecureKey);
    _token = null;

    checkForHttpError(response);
  }

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
}
