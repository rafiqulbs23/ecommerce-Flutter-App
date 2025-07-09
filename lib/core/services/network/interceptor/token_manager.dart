import 'dart:developer';

import 'package:dio/dio.dart';


import '../../../constants/storage_keys.dart';
import '../../storage/storage_service.dart';


class TokenManager extends Interceptor {

  TokenManager({
    required this.storageFuture,
    required this.refreshTokenEndpoint,
    required this.accessTokenKey,
    this.refreshTokenKey = 'n/a',
  });

  final Future<StorageService> storageFuture;
  final String? refreshTokenEndpoint;
  final String accessTokenKey;
  final String refreshTokenKey;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = accessToken;
    }
    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    // Function to recursively search for keys in a nested JSON object
    void findTokens(Map<String, dynamic> json) {
      for (var key in json.keys) {
        var value = json[key];

        if ((accessTokenKey == key) && value is String) {
          log(
            'Found access token: $value',
            name: 'RestClientKit/TokenStorageHandler',
          );
          saveToken(accessTokenKey, value);
        } else if ((refreshTokenKey == key) && value is String) {
          log(
            'Found refresh token: $value',
            name: 'RestClientKit/TokenStorageHandler',
          );
          saveToken(refreshTokenKey, value);
        } else if (value is Map<String, dynamic>) {
          findTokens(value);
        } else if (value is List) {
          for (var item in value) {
            if (item is Map<String, dynamic>) {
              findTokens(item);
            }
          }
        }
      }
    }

    try {
      if (response.data is Map<String, dynamic>) {
        findTokens(response.data);
      }
    } catch (e, stackTrace) {
      log(
        'Failed to parse tokens: $e',
        name: 'RestClientKit/TokenStorageHandler',
        error: e,
        stackTrace: stackTrace,
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final storage = await storageFuture;
      await storage.remove(accessTokenKey);
    }

    //TODO: Implement refresh token logic
    super.onError(err, handler);
  }

  Future<void> saveToken(String key, String value) async {
    final storage = await storageFuture;
    await storage.store(key, value);
  }

  Future<String?> getAccessToken() async {
    final storage = await storageFuture;
    return storage.get(accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final storage = await storageFuture;
    return storage.get(refreshTokenKey);
  }

}