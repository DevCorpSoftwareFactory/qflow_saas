import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/cash_session/cash_session_bloc.dart';
import '../../../services/dto/create_sale_dto.dart';
import '../../../data/local/tables/enums.dart';
import '../../screens/sales/receipt_preview_screen.dart';
import 'package:intl/intl.dart';

/// Stores checkout context for receipt preview navigation.
class _CheckoutContext {
  final List<PaymentDto> payments;
  final String tenantName;
  final String branchName;
  final String cashierName;
  final double change;

  _CheckoutContext({
    required this.payments,
    required this.tenantName,
    required this.branchName,
    required this.cashierName,
    required this.change,
  });
}

/// Singleton to pass checkout context to the listener.
_CheckoutContext? _lastCheckoutContext;

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
                  'Carrito',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    context.read<CartBloc>().add(CartCleared());
                  },
                  tooltip: 'Limpiar carrito',
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
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Carrito vacío',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
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
                            currencyFormat.format(item.subtotal),
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
              if (state.status == CartStatus.success &&
                  state.lastSaleResult != null &&
                  _lastCheckoutContext != null) {
                // Navigate to receipt preview
                ReceiptPreviewScreen.show(
                  context,
                  saleResult: state.lastSaleResult!,
                  payments: _lastCheckoutContext!.payments,
                  tenantName: _lastCheckoutContext!.tenantName,
                  branchName: _lastCheckoutContext!.branchName,
                  cashierName: _lastCheckoutContext!.cashierName,
                  change: _lastCheckoutContext!.change,
                );
                // Clear context
                _lastCheckoutContext = null;
              } else if (state.status == CartStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Error en checkout'),
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
                    // Promotions Input
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Código promocional',
                              isDense: true,
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                context
                                    .read<CartBloc>()
                                    .add(CartPromotionApplied(value));
                              }
                            },
                          ),
                        ),
                        if (state.promoCode != null)
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(const CartPromotionApplied('CLEAR'));
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Totals breakdown
                    _TotalsRow(
                      label: 'Subtotal:',
                      value: currencyFormat.format(state.subtotal),
                    ),
                    if (state.discountAmount > 0) ...[
                      _TotalsRow(
                        label: 'Descuento (${state.promoCode}):',
                        value:
                            '-${currencyFormat.format(state.discountAmount)}',
                        valueColor: Colors.green,
                      ),
                    ],
                    _TotalsRow(
                      label: 'IVA (19%):',
                      value: currencyFormat.format(state.taxAmount),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          currencyFormat.format(state.total),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: state.items.isEmpty ||
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
                        label: const Text('COBRAR'),
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
      barrierDismissible: false,
      builder: (ctx) => CheckoutDialog(
        total: total,
        onCheckout: (payments) => _submitCheckout(context, payments),
      ),
    );
  }

  void _submitCheckout(BuildContext context, List<PaymentDto> payments) {
    final authState = context.read<AuthBloc>().state;
    if (authState is! AuthAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario no autenticado')),
      );
      return;
    }

    // Get active cash session if available
    final cashSessionState = context.read<CashSessionBloc>().state;
    String? cashSessionId;
    if (cashSessionState is CashSessionActive) {
      cashSessionId = cashSessionState.sessionId;
    }

    // Calculate change for receipt
    final cartState = context.read<CartBloc>().state;
    final totalPaid = payments.fold(0.0, (sum, p) => sum + p.amount);
    final change = totalPaid - cartState.total;

    // Store context for receipt preview navigation
    _lastCheckoutContext = _CheckoutContext(
      payments: payments,
      tenantName: authState.tenantName,
      branchName: authState.branchName,
      cashierName: authState.userName,
      change: change > 0 ? change : 0,
    );

    context.read<CartBloc>().add(
          CartCheckoutRequested(
            userId: authState.userId,
            tenantId: authState.tenantId,
            branchId: authState.branchId,
            payments: payments,
            cashSessionId: cashSessionId,
            tenantName: authState.tenantName,
            branchName: authState.branchName,
            cashierName: authState.userName,
          ),
        );
  }
}

class _TotalsRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _TotalsRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: TextStyle(color: valueColor),
          ),
        ],
      ),
    );
  }
}

/// Dialog for selecting payment method(s) and completing checkout.
/// Supports split payments (multiple payment methods).
class CheckoutDialog extends StatefulWidget {
  final double total;
  final Function(List<PaymentDto>) onCheckout;

  const CheckoutDialog({
    super.key,
    required this.total,
    required this.onCheckout,
  });

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final List<PaymentDto> _payments = [];
  late TextEditingController _amountController;
  PaymentMethod _selectedMethod = PaymentMethod.cash;
  String? _reference;

  final currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.total.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _totalPaid => _payments.fold(0, (sum, p) => sum + p.amount);
  double get _remaining => widget.total - _totalPaid;
  double get _change => _totalPaid - widget.total;
  bool get _canComplete => _remaining <= 0;

  void _addPayment() {
    final amount = double.tryParse(
          _amountController.text.replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;

    if (amount <= 0) return;

    setState(() {
      _payments.add(PaymentDto(
        method: _selectedMethod,
        amount: amount,
        reference: _reference,
      ));
      _amountController.text =
          _remaining > 0 ? _remaining.toStringAsFixed(0) : '0';
      _reference = null;
    });
  }

  void _removePayment(int index) {
    setState(() {
      _payments.removeAt(index);
      if (_remaining > 0) {
        _amountController.text = _remaining.toStringAsFixed(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cobrar'),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Display
              Center(
                child: Column(
                  children: [
                    Text(
                      'Total a cobrar',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      currencyFormat.format(widget.total),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Added payments list
              if (_payments.isNotEmpty) ...[
                const Text('Pagos agregados:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...List.generate(_payments.length, (index) {
                  final p = _payments[index];
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_getMethodIcon(p.method)),
                    title: Text(_getMethodName(p.method)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currencyFormat.format(p.amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => _removePayment(index),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Pagado:'),
                    Text(
                      currencyFormat.format(_totalPaid),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_remaining > 0 ? 'Faltante:' : 'Cambio:'),
                    Text(
                      currencyFormat
                          .format(_remaining > 0 ? _remaining : _change),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _remaining > 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // Add payment form
              if (!_canComplete) ...[
                const Text('Agregar pago:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                // Payment method selection
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: PaymentMethod.values.map((method) {
                    final isSelected = _selectedMethod == method;
                    return FilterChip(
                      selected: isSelected,
                      label: Text(_getMethodName(method)),
                      avatar: Icon(
                        _getMethodIcon(method),
                        size: 18,
                      ),
                      onSelected: (selected) {
                        setState(() => _selectedMethod = method);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Amount input
                TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    prefixText: '\$ ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),

                // Quick amount buttons
                if (_selectedMethod == PaymentMethod.cash) ...[
                  Wrap(
                    spacing: 8,
                    children: [
                      _QuickAmountButton(
                        amount: widget.total,
                        label: 'Exacto',
                        onPressed: () => _amountController.text =
                            widget.total.toStringAsFixed(0),
                      ),
                      _QuickAmountButton(
                        amount: 50000,
                        onPressed: () => _amountController.text = '50000',
                      ),
                      _QuickAmountButton(
                        amount: 100000,
                        onPressed: () => _amountController.text = '100000',
                      ),
                      _QuickAmountButton(
                        amount: 200000,
                        onPressed: () => _amountController.text = '200000',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],

                // Reference input for non-cash
                if (_selectedMethod != PaymentMethod.cash) ...[
                  TextField(
                    decoration: InputDecoration(
                      labelText: _selectedMethod == PaymentMethod.card
                          ? 'Últimos 4 dígitos'
                          : 'Referencia',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (v) => _reference = v,
                  ),
                  const SizedBox(height: 8),
                ],

                // Add payment button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _addPayment,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar pago'),
                  ),
                ),
              ],

              // Change display for cash
              if (_canComplete && _change > 0) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'CAMBIO:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        currencyFormat.format(_change),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCELAR'),
        ),
        FilledButton(
          onPressed: _canComplete
              ? () {
                  widget.onCheckout(_payments);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('CONFIRMAR'),
        ),
      ],
    );
  }

  String _getMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.transfer:
        return 'Transferencia';
      case PaymentMethod.nequi:
        return 'Nequi';
      case PaymentMethod.credit:
        return 'Crédito';
    }
  }

  IconData _getMethodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return Icons.payments;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.transfer:
        return Icons.account_balance;
      case PaymentMethod.nequi:
        return Icons.phone_android;
      case PaymentMethod.credit:
        return Icons.assignment;
    }
  }
}

class _QuickAmountButton extends StatelessWidget {
  final double amount;
  final String? label;
  final VoidCallback onPressed;

  const _QuickAmountButton({
    required this.amount,
    this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.compactCurrency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return ActionChip(
      label: Text(label ?? currencyFormat.format(amount)),
      onPressed: onPressed,
    );
  }
}
