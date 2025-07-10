import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/retry_button.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {

  @override
  void initState() {
    Future.microtask((){
     final cartState = ref.read(cartProvider);
      if (cartState == null) {
        ref.read(cartProvider.notifier).getCard();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartState?.when(
          data: (products) {
            if (products.isEmpty == true) {
              return _buildEmptyCart();
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)} x ${product.quantity}'),
                  trailing: Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RetryButton(
                    error: error.toString(),
                    onPressed: () {
                      ref.refresh(cartProvider);
                    },
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          )
      )


    );
  }
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to home screen or add products
              Navigator.pop(context);
            },
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}
