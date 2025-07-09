
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/useCases/home_products_usecase.dart';

part 'home_provider.g.dart';

@riverpod
class Home extends _$Home{
  late HomeProductsUseCase useCase;
  int limit = 10;
  int skip = 0;


  @override
  AsyncValue<ProductEntity>? build() {
    useCase = getIt<HomeProductsUseCase>();
    return null;
  }


  Future<void> getProducts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {

      final result = await useCase.call(limit, skip);
      skip += limit;
      return result;
    });
  }

  Future<void> loadMore() async {
    if (state?.value?.total != null &&
        state?.value?.skip != null &&
        state!.value!.total <= state!.value!.skip) {
      return;
    }
    state = const AsyncLoading();
    final oldData = state?.value;
    state = await AsyncValue.guard(() async {
      final result = await useCase.call(limit, skip);
      skip += limit;
      return result;
    });
    if (oldData != null && state!.value != null) {
      state = AsyncValue.data(
        ProductEntity(
          products: [...oldData.products, ...state!.value!.products],
          total: state!.value!.total,
          skip: state?.value?.skip ?? skip,
          limit: state?.value?.limit ?? limit,
        ),
      );
    }

  }

}