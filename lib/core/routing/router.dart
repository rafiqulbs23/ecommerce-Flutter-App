import 'package:ecommerce_app/features/homeScreen/presentation/pages/home_screen.dart';
import 'package:ecommerce_app/features/productDetails/presentation/pages/product_details.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/homeScreen/domain/entity/product_entity.dart' as myProduct;

import '../../features/loginScreen/presentation/pages/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        final product = state.extra as myProduct.Product; // cast extra to your model class

        return ProductDetails(
          productId: productId,
          product: product,
        );
      },
    )
  ],
);