import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_products_repository.dart';
import '../dataSources/home_remote_data_source.dart';
import '../model/product_response.dart';

@LazySingleton(as: HomeProductsRepository)
class HomeProductRepositoryImpl extends HomeProductsRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductEntity> getHomeProducts(int limit, int skip) async {
    try {
      final response = await remoteDataSource.getHomeProducts(limit,skip);
      final products = productResponseToJson(response);

      return productEntityFromJson(products);
    }on DioException catch (e){
      throw Exception(e.error.toString());
    }
  }
}