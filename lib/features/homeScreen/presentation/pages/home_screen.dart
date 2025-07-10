import 'package:ecommerce_app/features/homeScreen/presentation/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/retry_button.dart';
import '../widgets/product_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}
class Product {
  final String title;
  final String imageUrl;
  final double price;

  Product({required this.title, required this.imageUrl, required this.price});
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController _scrollController;



  @override
  void initState() {
    _scrollController = ScrollController();
    Future.microtask(() {
      ref.read(homeProvider.notifier).getProducts();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        Future.microtask(() {
          ref.read(homeProvider.notifier).loadMore();
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final isLoading = ref.watch(isLoadingMoreProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.push('/cart');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: homeState?.when(
                data: (data) =>
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: data.products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // two items per row
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                          mainAxisExtent: 300,
                        ),
                        itemBuilder: (context, index) {
                          final product = data.products[index];
                          return ProductCard(
                            title: product.title,
                            imageUrl: product.thumbnail,
                            price: product.price,
                            onAddToCart: () {
                              context.push(
                                  '/product/${product.id}',
                                  extra: product
                              );
                            },
                          );
                        },
                      ),
                    ),
                error: (error, stackTrace) =>RetryButton(
                  error: error.toString(),
                  onPressed: () {
                    ref.read(homeProvider.notifier).getProducts();
                  },
                ),
                loading: () =>
                 Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: const Color(0xFF1A1A3F),
                    size: 50,
                  ),
                ),
              )??SizedBox.shrink()
            ),
            if (isLoading)
               Center(
                 child: LoadingAnimationWidget.horizontalRotatingDots(
                   color: const Color(0xFF1A1A3F),
                   size: 50,
                 ),
               ),
          ],
        )
    );
  }
}
