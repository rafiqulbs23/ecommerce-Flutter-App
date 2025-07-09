
import 'package:injectable/injectable.dart';

import '../entity/product_entity.dart';
import '../repository/home_products_repository.dart';

@injectable
class HomeProductsUseCase {
  final HomeProductsRepository _homeProductsRepository;
  HomeProductsUseCase(this._homeProductsRepository);

  Future<ProductEntity> call(int limit,int skip) async {
    return await _homeProductsRepository.getHomeProducts(limit,skip);
  }
}