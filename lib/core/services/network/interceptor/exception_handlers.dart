import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class ExceptionHandlerInterceptor extends Interceptor {
  ExceptionHandlerInterceptor({this.onUnAuthorizedError});
  final VoidCallback? onUnAuthorizedError;
  String message = '';

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final error = _handleError(err);
      handler.reject(error);
    } catch (_) {
      handler.reject(err);
    }
  }

  DioException _handleError(DioException err) {
    final response = err.response;
    String? errorMessage;

    if (response?.statusCode == 401) {
      onUnAuthorizedError?.call();
    }

    try {
      final data = response?.data;

      if (data is Map && data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (data is String) {
        final decoded = jsonDecode(data);
        errorMessage = decoded['message'] ?? 'Unknown error';
        message = errorMessage ?? "";
      }
    } catch (_) {
      errorMessage = 'Something went wrong';
    }

    return DioException(
      requestOptions: err.requestOptions,
      response: response,
      type: err.type,
      error: errorMessage ?? err.error,
    );
  }
}
