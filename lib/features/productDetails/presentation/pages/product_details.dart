import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../CartScreen/data/model/cart_response.dart';
import '../../../CartScreen/presentation/providers/cart_provider.dart' as cartProvider;
import '../../../homeScreen/domain/entity/product_entity.dart';

class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails({super.key,required this.productId, required this.product});
  final String productId;
  final Product product;

  @override
  ConsumerState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.title}'),
      ),
      body: Column(
        children: [
          Image.network(widget.product.thumbnail),
          const Text(
            'Product Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Product ID: ${widget.productId}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Title: ${widget.product.title}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Price: \$${widget.product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Description: ${widget.product.description}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Category: ${widget.product.category}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue, // Background color
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button background
                    foregroundColor: Colors.blueAccent, // Text/icon color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final cartState = ref.read(cartProvider.cartProvider.notifier);
                    cartState.addOrUpdateProduct(
                      CartProduct(
                        id: widget.product.id,
                        name: widget.product.title,
                        price: widget.product.price,
                        quantity: 1, // Default quantity
                        imageUrl: widget.product.thumbnail,
                      ),
                    );
                  },
                  child: const Text('Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
