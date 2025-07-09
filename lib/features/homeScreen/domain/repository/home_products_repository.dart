
import '../entity/product_entity.dart';

abstract class HomeProductsRepository {
  Future<ProductEntity> getHomeProducts(int limit, int skip);
}