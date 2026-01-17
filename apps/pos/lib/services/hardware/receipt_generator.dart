import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import '../dto/create_sale_dto.dart';
import '../sales_service.dart';
import '../cash_session_service.dart';

/// Generates ESC/POS thermal receipt bytes.
class ReceiptGenerator {
  final _currencyFormat = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
    locale: 'es_CO',
  );

  /// Generate receipt from SaleResult (preferred method).
  Future<List<int>> generateReceiptFromResult({
    required SaleResult saleResult,
    required List<PaymentDto> payments,
    required String tenantName,
    required String branchName,
    required String cashierName,
    required double change,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // ========= HEADER =========
    bytes += generator.text(
      tenantName,
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += generator.text(
      branchName,
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.feed(1);

    // ========= SALE INFO =========
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    bytes += generator.text('Fecha: ${dateFormat.format(DateTime.now())}');
    bytes += generator.text('Venta: ${saleResult.saleNumber}');
    bytes += generator.text('Cajero: $cashierName');
    bytes += generator.hr();

    // ========= ITEMS =========
    bytes += generator.row([
      PosColumn(
          text: 'Producto', width: 6, styles: const PosStyles(bold: true)),
      PosColumn(
        text: 'Cant',
        width: 2,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
      PosColumn(
        text: 'Total',
        width: 4,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
    ]);

    for (final item in saleResult.items) {
      // Try to get product name from the first item if available
      // For now, use lot number as identifier
      final displayName = 'Lote: ${item.lotNumber.substring(0, 8)}...';

      bytes += generator.text(displayName, styles: const PosStyles(bold: true));
      bytes += generator.row([
        PosColumn(
          text: '@ ${_currencyFormat.format(item.unitPrice)}',
          width: 6,
        ),
        PosColumn(
          text: item.quantity.toString(),
          width: 2,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: _currencyFormat.format(item.subtotal),
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.hr();

    // ========= TOTALS =========
    bytes += generator.row([
      PosColumn(text: 'Subtotal:', width: 6),
      PosColumn(
        text: _currencyFormat.format(saleResult.totals.subtotal),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(text: 'IVA (19%):', width: 6),
      PosColumn(
        text: _currencyFormat.format(saleResult.totals.taxAmount),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr(ch: '=');
    bytes += generator.row([
      PosColumn(
        text: 'TOTAL',
        width: 6,
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
        ),
      ),
      PosColumn(
        text: _currencyFormat.format(saleResult.totals.totalAmount),
        width: 6,
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
          align: PosAlign.right,
        ),
      ),
    ]);
    bytes += generator.hr(ch: '=');

    // ========= PAYMENTS =========
    bytes += generator.feed(1);
    bytes +=
        generator.text('FORMA DE PAGO:', styles: const PosStyles(bold: true));

    for (final payment in payments) {
      final methodName = _getPaymentMethodName(payment.method);
      bytes += generator.row([
        PosColumn(text: methodName, width: 6),
        PosColumn(
          text: _currencyFormat.format(payment.amount),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);

      if (payment.reference != null && payment.reference!.isNotEmpty) {
        bytes += generator.text(
          '  Ref: ${payment.reference}',
          styles: const PosStyles(fontType: PosFontType.fontB),
        );
      }
    }

    // ========= CHANGE =========
    if (change > 0) {
      bytes += generator.feed(1);
      bytes += generator.row([
        PosColumn(
          text: 'CAMBIO:',
          width: 6,
          styles: const PosStyles(bold: true),
        ),
        PosColumn(
          text: _currencyFormat.format(change),
          width: 6,
          styles: const PosStyles(bold: true, align: PosAlign.right),
        ),
      ]);
    }

    // ========= FOOTER =========
    bytes += generator.feed(2);
    bytes += generator.text(
      '¡Gracias por su compra!',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.text(
      'Conserve este recibo',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.feed(1);
    bytes += generator.cut();

    return bytes;
  }

  /// Legacy method for backwards compatibility.
  Future<List<int>> generateReceipt(
    CreateSaleDto sale,
    String tenantName,
    String branchName,
    String cashierName,
    String saleId,
    DateTime date,
  ) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // Header
    bytes += generator.text(
      tenantName,
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += generator.text(
      branchName,
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.feed(1);

    // Info
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    bytes += generator.text('Fecha: ${dateFormat.format(date)}');
    bytes += generator.text('Venta: #$saleId');
    bytes += generator.text('Cajero: $cashierName');
    bytes += generator.hr();

    // Items
    bytes += generator.row([
      PosColumn(
          text: 'Producto', width: 6, styles: const PosStyles(bold: true)),
      PosColumn(
        text: 'Cant',
        width: 2,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
      PosColumn(
        text: 'Total',
        width: 4,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
    ]);

    double subtotal = 0;
    for (final item in sale.items) {
      final itemTotal = item.unitPrice * item.quantity;
      subtotal += itemTotal;

      // Use product name if available, otherwise variant ID
      final displayName =
          item.productName ?? '${item.variantId.substring(0, 8)}...';

      bytes += generator.text(displayName);
      bytes += generator.row([
        PosColumn(
          text: '@ ${_currencyFormat.format(item.unitPrice)}',
          width: 6,
        ),
        PosColumn(
          text: item.quantity.toString(),
          width: 2,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: _currencyFormat.format(itemTotal),
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.hr();

    // Totals
    final taxAmount = subtotal * 0.19;
    final total = subtotal + taxAmount - (sale.discountAmount ?? 0);

    bytes += generator.row([
      PosColumn(text: 'Subtotal:', width: 6),
      PosColumn(
        text: _currencyFormat.format(subtotal),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    if (sale.discountAmount != null && sale.discountAmount! > 0) {
      bytes += generator.row([
        PosColumn(text: 'Descuento:', width: 6),
        PosColumn(
          text: '-${_currencyFormat.format(sale.discountAmount)}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.row([
      PosColumn(text: 'IVA (19%):', width: 6),
      PosColumn(
        text: _currencyFormat.format(taxAmount),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'TOTAL',
        width: 6,
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
        ),
      ),
      PosColumn(
        text: _currencyFormat.format(total),
        width: 6,
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
          align: PosAlign.right,
        ),
      ),
    ]);

    // Payments
    bytes += generator.feed(1);
    bytes +=
        generator.text('FORMA DE PAGO:', styles: const PosStyles(bold: true));
    for (final payment in sale.payments) {
      bytes += generator.row([
        PosColumn(text: _getPaymentMethodName(payment.method), width: 6),
        PosColumn(
          text: _currencyFormat.format(payment.amount),
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.feed(2);
    bytes += generator.text(
      '¡Gracias por su compra!',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.feed(1);
    bytes += generator.cut();

    return bytes;
  }

  String _getPaymentMethodName(dynamic method) {
    final methodName = method.toString().split('.').last.toLowerCase();
    switch (methodName) {
      case 'cash':
        return 'Efectivo';
      case 'card':
        return 'Tarjeta';
      case 'transfer':
        return 'Transferencia';
      case 'nequi':
        return 'Nequi';
      case 'credit':
        return 'Crédito';
      default:
        return methodName.toUpperCase();
    }
  }

  /// Generate cash session closure report.
  Future<List<int>> generateSessionReport({
    required CashSessionSummary summary,
    required String tenantName,
    required String branchName,
    required String cashierName,
    required double declaredAmount,
    required double difference,
    String? justification,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    // Header
    bytes += generator.text(
      tenantName,
      styles: const PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += generator.text(
      branchName,
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.feed(1);
    bytes += generator.text(
      'CIERRE DE CAJA',
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
      ),
    );
    bytes += generator.feed(1);

    // Info
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    bytes += generator.text('Cajero: $cashierName');
    bytes += generator
        .text('Apertura: ${dateFormat.format(summary.session.createdAt)}');
    if (summary.session.closingDate != null) {
      bytes += generator
          .text('Cierre: ${dateFormat.format(summary.session.closingDate!)}');
    }
    bytes += generator.hr();

    // Summary
    bytes += generator.row([
      PosColumn(
          text: 'Concepto', width: 8, styles: const PosStyles(bold: true)),
      PosColumn(
        text: 'Monto',
        width: 4,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
    ]);

    void addRow(String label, double amount, {bool isNegative = false}) {
      bytes += generator.row([
        PosColumn(text: label, width: 8),
        PosColumn(
          text: (isNegative ? '-' : '') + _currencyFormat.format(amount),
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    addRow('Base Inicial', summary.session.initialAmount);
    // Calculate approximate generated income (Total Income - Base)
    // Assuming Base is counted in Total Income in the summary calculation
    // If Summary logic iterates all Income movements, and Base is an Income movement, then Yes.
    // Let's rely on Summary totals for now which are aggregate.
    // If I show Base + Total Income (Active), it might be better.
    // But `totalIncome` in summary captures ALL income movements.

    addRow('Total Ingresos', summary.totalIncome);
    addRow('Total Egresos', summary.totalExpenses, isNegative: true);
    addRow('Total Retiros', summary.totalWithdrawals, isNegative: true);

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL SISTEMA', width: 6, styles: const PosStyles(bold: true)),
      PosColumn(
        text: _currencyFormat.format(summary.currentSystemAmount),
        width: 6,
        styles: const PosStyles(bold: true, align: PosAlign.right),
      ),
    ]);

    bytes += generator.feed(1);
    bytes += generator.text('ARQUEO',
        styles: const PosStyles(bold: true, underline: true));

    bytes += generator.row([
      PosColumn(text: 'Declarado:', width: 6),
      PosColumn(
        text: _currencyFormat.format(declaredAmount),
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(text: 'Diferencia:', width: 6),
      PosColumn(
        text: _currencyFormat.format(difference),
        width: 6,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]);

    if (justification != null && justification.isNotEmpty) {
      bytes += generator.feed(1);
      bytes += generator.text('Justificación:');
      bytes += generator.text(justification);
    }

    bytes += generator.feed(3);
    bytes += generator.text('_______________________',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Firma Cajero',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
