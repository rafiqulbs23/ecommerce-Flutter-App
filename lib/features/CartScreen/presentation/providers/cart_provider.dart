

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/storage/storage_service.dart';
import '../../data/model/cart_response.dart';

part 'cart_provider.g.dart';
@riverpod
@riverpod
class Cart extends _$Cart {
  final List<CartProduct> allProduct = [];

  @override
  AsyncValue<List<CartProduct>>? build()  {
    return null;
  }


  Future<void> getCard() async {

    final storage = getIt<StorageService>();

    state = await AsyncValue.guard(() async {
      final raw = await storage.get(StorageKeys.cart);

      if (raw != null && raw is List) {
        final cartItems = raw.map((e) => CartProduct.fromJson(e as Map<String, dynamic>)).toList();
        return cartItems;
      }
      return [];
    });
  }


  Future<void> addOrUpdateProduct(CartProduct newProduct) async {
    final index = allProduct.indexWhere((p) => p.id == newProduct.id);

    if (index != -1) {
      final existing = allProduct[index];
      allProduct[index] = existing.copyWith(
        quantity: existing.quantity + newProduct.quantity,
      );
    } else {
      allProduct.add(newProduct);
    }

    final storage = getIt<StorageService>();
    await storage.store(
      StorageKeys.cart,
      allProduct.map((p) => p.toJson()).toList(),
    );

    final raw = await storage.get(StorageKeys.cart);

    if (raw != null && raw is List) {
      allProduct.addAll(
        raw.map((e) => CartProduct.fromJson(e)).toList(),
      );
    }
    state = await AsyncValue.guard(() async {
      return allProduct;
    });

  }
}
