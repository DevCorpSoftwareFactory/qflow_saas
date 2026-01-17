// =============================================================================
// Receipt Widget - Visual representation of a sale receipt
// =============================================================================
// This widget renders the receipt for on-screen display.
// Unlike the ReceiptGenerator (ESC/POS bytes), this is for visual preview.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/sales_service.dart';
import '../../../services/dto/create_sale_dto.dart';
import '../../../data/local/tables/enums.dart';

/// Visual representation of a sale receipt for on-screen display.
class ReceiptWidget extends StatelessWidget {
  final SaleResult saleResult;
  final List<PaymentDto> payments;
  final String tenantName;
  final String branchName;
  final String cashierName;
  final double change;
  final DateTime? saleDate;

  const ReceiptWidget({
    super.key,
    required this.saleResult,
    required this.payments,
    required this.tenantName,
    required this.branchName,
    required this.cashierName,
    required this.change,
    this.saleDate,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
      locale: 'es_CO',
    );
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final effectiveDate = saleDate ?? DateTime.now();

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ========= HEADER =========
            _ReceiptHeader(
              tenantName: tenantName,
              branchName: branchName,
            ),
            const SizedBox(height: 16),

            // ========= SALE INFO =========
            _ReceiptInfo(
              saleNumber: saleResult.saleNumber,
              cashierName: cashierName,
              date: dateFormat.format(effectiveDate),
            ),
            const _ReceiptDivider(),

            // ========= ITEMS =========
            _ItemsHeader(),
            const SizedBox(height: 8),
            ...saleResult.items.map((item) => _ReceiptItem(
                  name: 'Producto ${item.variantId.substring(0, 8)}',
                  quantity: item.quantity,
                  unitPrice: item.unitPrice,
                  subtotal: item.subtotal,
                  lotNumber: item.lotNumber,
                  currencyFormat: currencyFormat,
                )),
            const _ReceiptDivider(),

            // ========= TOTALS =========
            _TotalsSection(
              subtotal: saleResult.totals.subtotal,
              taxAmount: saleResult.totals.taxAmount,
              totalAmount: saleResult.totals.totalAmount,
              currencyFormat: currencyFormat,
            ),
            const _ReceiptDivider(thick: true),

            // ========= PAYMENTS =========
            const SizedBox(height: 8),
            const Text(
              'FORMA DE PAGO:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(height: 4),
            ...payments.map((payment) => _PaymentRow(
                  payment: payment,
                  currencyFormat: currencyFormat,
                )),

            // ========= CHANGE =========
            if (change > 0) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'CAMBIO:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      currencyFormat.format(change),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // ========= FOOTER =========
            const SizedBox(height: 16),
            const Text(
              '¡Gracias por su compra!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Conserve este recibo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// Private Helper Widgets
// =============================================================================

class _ReceiptHeader extends StatelessWidget {
  final String tenantName;
  final String branchName;

  const _ReceiptHeader({
    required this.tenantName,
    required this.branchName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tenantName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          branchName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ReceiptInfo extends StatelessWidget {
  final String saleNumber;
  final String cashierName;
  final String date;

  const _ReceiptInfo({
    required this.saleNumber,
    required this.cashierName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(label: 'Fecha:', value: date),
        _InfoRow(label: 'Venta:', value: saleNumber),
        _InfoRow(label: 'Cajero:', value: cashierName),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptDivider extends StatelessWidget {
  final bool thick;

  const _ReceiptDivider({this.thick = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: thick ? 2 : 1,
        color: thick ? Colors.black : Colors.grey.shade300,
      ),
    );
  }
}

class _ItemsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 5,
          child: Text(
            'Producto',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const Expanded(
          flex: 2,
          child: Text(
            'Cant',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
          flex: 3,
          child: Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _ReceiptItem extends StatelessWidget {
  final String name;
  final int quantity;
  final double unitPrice;
  final double subtotal;
  final String lotNumber;
  final NumberFormat currencyFormat;

  const _ReceiptItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.lotNumber,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  currencyFormat.format(subtotal),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Text(
            '@ ${currencyFormat.format(unitPrice)} • Lote: ${lotNumber.length > 8 ? lotNumber.substring(0, 8) : lotNumber}...',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalsSection extends StatelessWidget {
  final double subtotal;
  final double taxAmount;
  final double totalAmount;
  final NumberFormat currencyFormat;

  const _TotalsSection({
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TotalRow(
          label: 'Subtotal:',
          value: currencyFormat.format(subtotal),
        ),
        _TotalRow(
          label: 'IVA (19%):',
          value: currencyFormat.format(taxAmount),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'TOTAL',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currencyFormat.format(totalAmount),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;

  const _TotalRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final PaymentDto payment;
  final NumberFormat currencyFormat;

  const _PaymentRow({
    required this.payment,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    _getPaymentIcon(payment.method),
                    size: 16,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getPaymentMethodName(payment.method),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Text(
                currencyFormat.format(payment.amount),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (payment.reference != null && payment.reference!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                'Ref: ${payment.reference}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getPaymentMethodName(PaymentMethod method) {
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

  IconData _getPaymentIcon(PaymentMethod method) {
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
