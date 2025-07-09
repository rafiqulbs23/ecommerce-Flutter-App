import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/network/rest_client.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';




@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptor to Dio instance
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    return dio;
  }

  @lazySingleton
  RestClient get restClient => RestClient(dio);
}
