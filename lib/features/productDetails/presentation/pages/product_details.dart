import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    );
  }
}
