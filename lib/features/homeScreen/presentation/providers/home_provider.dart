
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  bool isLoadingMore = false;



  @override
  AsyncValue<ProductEntity>? build() {
    useCase = getIt<HomeProductsUseCase>();
    return null;
  }


  Future<void> getProducts() async {
    int skip = 0;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {

      final result = await useCase.call(limit, skip);
      skip += limit;
      return result;
    });
  }



  Future<void> loadMore() async {
    if (isLoadingMore) return;
    if (state?.value?.total != null &&
        state?.value?.skip != null &&
        state!.value!.total <= state!.value!.skip) {
      return;
    }

    ref.read(isLoadingMoreProvider.notifier).state = true;
    final oldData = state?.value;

    final newData = await AsyncValue.guard(() async {
      final result = await useCase.call(limit, skip);
      skip += limit;
      return result;
    });

    if (oldData != null && newData.value != null) {
      state = AsyncValue.data(
        ProductEntity(
          products: [...oldData.products, ...newData.value!.products],
          total: newData.value!.total,
          skip: skip,
          limit: limit,
        ),
      );
    } else {
      state = newData;
    }

    ref.read(isLoadingMoreProvider.notifier).state = false;

  }


}

final isLoadingMoreProvider = StateProvider<bool>((ref) => false);
