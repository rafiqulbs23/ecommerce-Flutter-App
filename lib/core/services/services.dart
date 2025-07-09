import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/services/storage/objectbox_storage_service.dart';
import 'package:ecommerce_app/core/services/storage/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'network/interceptor/exception_handlers.dart';
import 'network/interceptor/token_manager.dart';
import 'network/rest_client.dart';


@injectable
Future<StorageService> _initStorageService() async {
  final storage = ObjectBoxStorageService();
  await storage.initialize();
  return storage;
}

@module
abstract class RegisterModule {
  @preResolve
  @lazySingleton
  Future<StorageService> get storageService => _initStorageService();
}




@module
abstract class RegisterModuleForStorage {
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
    dio.interceptors.addAll(
      [
        TokenManager(
          storageFuture: Future.value(storageService()),
          refreshTokenEndpoint: 'auth/refreshToken',
          accessTokenKey: 'accessToken',
        ),
        ExceptionHandlerInterceptor(
          onUnAuthorizedError: () {},
        ),
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
          ),
      ],
    );

    return dio;
  }

  @lazySingleton
  RestClient get restClient => RestClient(dio);
}