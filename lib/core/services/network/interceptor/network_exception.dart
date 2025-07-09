import 'package:dio/src/dio_exception.dart';

class NetworkException implements Exception {
  const NetworkException({
    required this.statusCode,
    required this.message,
  });

  final int statusCode;
  final String message;

  @override
  String toString() => message;

  static fromDioException(DioException e) {
    return NetworkException(
      statusCode: e.response?.statusCode ?? 0,
      message: e.error.toString(),
    );
  }
}

extension ExceptionExtension on Exception {
  NetworkException toNetworkException() {
    if (this is NetworkException) {
      return this as NetworkException;
    } else {
      return NetworkException(
        statusCode: 0,
        message: toString(),
      );
    }
  }
}