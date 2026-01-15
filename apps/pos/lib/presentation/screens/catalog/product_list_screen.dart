import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/catalog/catalog_bloc.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = TextEditingController();
  final FocusNode _keyboardListenerFocus = FocusNode();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Trigger initial load
    context.read<CatalogBloc>().add(CatalogLoadStarted());
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<CatalogBloc>().add(CatalogSearchChanged(query));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _keyboardListenerFocus.dispose();
    super.dispose();
  }

  void _showManualBarcodeDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan/Enter Barcode'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Scan or type SKU/Barcode',
            prefixIcon: Icon(Icons.qr_code_scanner),
          ),
          onSubmitted: (value) {
            _handleBarcodeScan(value);
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _handleBarcodeScan(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _handleBarcodeScan(String code) {
    if (code.isEmpty) return;

    // Trigger search in CatalogBloc
    _searchController.text = code;
    context.read<CatalogBloc>().add(CatalogSearchChanged(code));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Scanned: $code')));
  }

  @override
  Widget build(BuildContext context) {
    // Wrap with KeyboardListener to capture scanner input (usually acting as keyboard)
    // For now, we rely on the search bar or the explicit button, but typically
    // a global listener handles "hidden" inputs from scanners.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search products by name, SKU or barcode...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: _showManualBarcodeDialog,
                tooltip: 'Scan Barcode',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              _onSearchChanged(value);
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CatalogError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text('Error: ${state.message}'),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          context.read<CatalogBloc>().add(CatalogLoadStarted());
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is CatalogLoaded) {
                if (state.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            context.read<CatalogBloc>().add(CatalogRefreshed());
                          },
                          icon: const Icon(Icons.cloud_sync),
                          label: const Text('Sync Catalog'),
                        ),
                      ],
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width > 1200
                        ? 5
                        : width > 800
                        ? 4
                        : width > 600
                        ? 3
                        : 2;

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<CatalogBloc>().add(CatalogRefreshed());
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final product = state.items[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              context.go('/pos/product/${product.variantId}');
                            },
                            onAddToCart: () {
                              context.read<CartBloc>().add(
                                CartItemAdded(product),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added ${product.productName} to cart',
                                  ),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  width: 400,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
