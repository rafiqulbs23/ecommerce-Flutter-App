
import '../model/product_response.dart';

abstract class HomeRemoteDataSource {
  Future<ProductResponse> getHomeProducts(int limit, int skip);
}