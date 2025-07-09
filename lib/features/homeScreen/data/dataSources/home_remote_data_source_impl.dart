
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/rest_client.dart';
import '../model/product_response.dart';
import 'home_remote_data_source.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final RestClient restClient;
  HomeRemoteDataSourceImpl({required this.restClient});
  @override
  Future<ProductResponse> getHomeProducts(int limit,int skip) async {
    final response = await restClient.getHomeProducts(limit, skip);
    return response;
  }

}