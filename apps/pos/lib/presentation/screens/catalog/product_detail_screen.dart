import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import 'package:intl/intl.dart';
import '../../../di/injection.dart';
import '../../../services/catalog_service.dart';
import '../../../services/stock_service.dart';
import '../../../data/dto/product_variant_view.dart';
import '../../blocs/cart/cart_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final String variantId;

  const ProductDetailScreen({super.key, required this.variantId});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: FutureBuilder<ProductVariantView?>(
        future: getIt<CatalogService>().getProductVariant(variantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final product = snapshot.data;
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Placeholder
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  product.productName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  product.categoryName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currencyFormat.format(product.price),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Stock Check
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        final branchId = authState is AuthAuthenticated
                            ? authState.branchId
                            : 'main'; // Should not happen in protected route

                        return FutureBuilder<bool>(
                          future: getIt<StockService>().checkAvailability(
                            variantId: variantId,
                            branchId: branchId,
                            quantity: 1,
                          ),
                          builder: (context, stockSnapshot) {
                            if (stockSnapshot.data == true) {
                              return const Chip(
                                label: Text('In Stock'),
                                avatar: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                backgroundColor: Colors.greenAccent,
                              );
                            }
                            return const Chip(
                              label: Text('Out of Stock'),
                              avatar: Icon(Icons.cancel, color: Colors.red),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                const Divider(),
                ListTile(
                  title: const Text('SKU'),
                  subtitle: Text(product.sku),
                  leading: const Icon(Icons.confirmation_number),
                ),
                if (product.barcode != null)
                  ListTile(
                    title: const Text('Barcode'),
                    subtitle: Text(product.barcode!),
                    leading: const Icon(Icons.qr_code),
                  ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      context.read<CartBloc>().add(CartItemAdded(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${product.productName} to cart'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      // Optional: Go back to list or cart
                      // context.pop();
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Add to Cart'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
