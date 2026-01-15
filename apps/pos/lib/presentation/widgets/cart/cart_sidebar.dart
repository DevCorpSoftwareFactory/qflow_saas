import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import 'package:intl/intl.dart';

class CartSidebar extends StatelessWidget {
  const CartSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(left: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 8),
                Text(
                  'Shopping Cart',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    context.read<CartBloc>().add(CartCleared());
                  },
                  tooltip: 'Clear Cart',
                ),
              ],
            ),
          ),

          // Items List
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 48,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text('Cart is empty'),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.items.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ListTile(
                      title: Text(item.product.productName),
                      subtitle: Text(
                        '${currencyFormat.format(item.product.price)} x ${item.quantity}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currencyFormat.format(
                              item.product.price * item.quantity,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              if (item.quantity > 1) {
                                context.read<CartBloc>().add(
                                  CartItemAdded(item.product, quantity: -1),
                                );
                              } else {
                                context.read<CartBloc>().add(
                                  CartItemRemoved(item.product.variantId),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Footer & Checkout
          BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state.status == CartStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sale successful!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state.status == CartStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Checkout failed'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:'),
                        Text(
                          currencyFormat.format(state.total),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed:
                            state.items.isEmpty ||
                                state.status == CartStatus.loading
                            ? null
                            : () => _showCheckoutDialog(context, state.total),
                        icon: state.status == CartStatus.loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.payment),
                        label: const Text('CHECKOUT'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, double total) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Payment Method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total to pay: \$${total.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Cash'),
              onTap: () => _submitCheckout(context, 'CASH', total),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit Card'),
              onTap: () => _submitCheckout(context, 'CARD', total),
            ),
          ],
        ),
      ),
    );
  }

  void _submitCheckout(BuildContext context, String method, double amount) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<CartBloc>().add(
        CartCheckoutRequested(
          userId: authState.userId,
          tenantId: authState.tenantId,
          branchId: authState.branchId,
          paymentMethod: method,
          amountTendered: amount,
        ),
      );
      Navigator.pop(context); // Close dialog
    } else {
      // Should not happen if guarded
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not authenticated')));
    }
  }
}
