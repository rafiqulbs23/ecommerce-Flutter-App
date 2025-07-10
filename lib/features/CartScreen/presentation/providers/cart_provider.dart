

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/storage/storage_service.dart';

part 'cart_provider.g.dart';
class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

@riverpod
class Cart extends _$Cart{
final List<Product> allProduct = [];



  @override
  AsyncValue<List<Product>>? build(){
    final storage = getIt<StorageService>();
    storage.get(StorageKeys.cart).then((value){
      if (value != null) {
        final List<dynamic> products = value as List<Product>;
        allProduct.addAll(products.map((e) => Product(
          id: e['id'],
          name: e['name'],
          price: e['price'],
          quantity: e['quantity'],
          imageUrl: e['imageUrl'],
        )).toList());
      }
      state = AsyncValue.data(allProduct);
    }).catchError((error) {
      //state = AsyncValue.error(error);
    });
    return null;
  }




Future<void> addOrUpdateProduct(Product newProduct) async {
  // 1. Find existing product in allProduct by id
  final index = allProduct.indexWhere((p) => p.id == newProduct.id);

  if (index != -1) {
    // Update quantity or other fields
    final existingProduct = allProduct[index];
    allProduct[index] = Product(
      id: existingProduct.id,
      name: existingProduct.name,
      price: existingProduct.price,
      quantity: existingProduct.quantity + newProduct.quantity,
      imageUrl: existingProduct.imageUrl,
    );
  } else {
    // Add new product
    allProduct.add(newProduct);
  }

  // 2. Save updated allProduct to local storage
  final storage = getIt<StorageService>();
  await storage.store(
    StorageKeys.cart,
    allProduct,
  );

  state = AsyncValue.data(List.from(allProduct));
}

Future<void> removeProduct(int productId) async {
  // 1. Remove product from allProduct by id
  allProduct.removeWhere((p) => p.id == productId);

  // 2. Save updated allProduct to local storage
  final storage = getIt<StorageService>();
  await storage.store(
    StorageKeys.cart,
    allProduct,
  );

  state = AsyncValue.data(List.from(allProduct));
}
Future<void> clearCart() async {
  // Clear the cart
  allProduct.clear();

  // Save empty cart to local storage
  final storage = getIt<StorageService>();
  await storage.store(
    StorageKeys.cart,
    allProduct,
  );

  state = AsyncValue.data(List.from(allProduct));
}




}