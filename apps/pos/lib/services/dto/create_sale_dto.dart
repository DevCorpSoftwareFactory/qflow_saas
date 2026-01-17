import '../../data/local/database.dart';

/// DTO for a payment within a sale.
/// Supports multiple payment methods per sale (split payments).
class PaymentDto {
  final PaymentMethod method;
  final double amount;
  final String? reference;
  final String? cardLastFour;

  const PaymentDto({
    required this.method,
    required this.amount,
    this.reference,
    this.cardLastFour,
  });

  /// Create a cash payment.
  factory PaymentDto.cash(double amount) => PaymentDto(
        method: PaymentMethod.cash,
        amount: amount,
      );

  /// Create a card payment.
  factory PaymentDto.card(double amount,
          {String? reference, String? lastFour}) =>
      PaymentDto(
        method: PaymentMethod.card,
        amount: amount,
        reference: reference,
        cardLastFour: lastFour,
      );

  /// Create a Nequi payment.
  factory PaymentDto.nequi(double amount, {String? reference}) => PaymentDto(
        method: PaymentMethod.nequi,
        amount: amount,
        reference: reference,
      );

  /// Create a transfer payment.
  factory PaymentDto.transfer(double amount, {String? reference}) => PaymentDto(
        method: PaymentMethod.transfer,
        amount: amount,
        reference: reference,
      );

  /// Create a credit payment (on customer account).
  factory PaymentDto.credit(double amount) => PaymentDto(
        method: PaymentMethod.credit,
        amount: amount,
      );

  Map<String, dynamic> toJson() => {
        'method': method.name,
        'amount': amount,
        'reference': reference,
        'cardLastFour': cardLastFour,
      };
}

/// DTO for creating a sale item.
class SaleItemDto {
  final String variantId;
  final String? lotId; // Optional: If not provided, FIFO will be used
  final int quantity;
  final double unitPrice;
  final double? discountPercent;
  final String? productName; // For receipt display

  const SaleItemDto({
    required this.variantId,
    this.lotId,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent,
    this.productName,
  });

  double get subtotal =>
      unitPrice * quantity * (1 - (discountPercent ?? 0) / 100);

  Map<String, dynamic> toJson() => {
        'variantId': variantId,
        'lotId': lotId,
        'quantity': quantity,
        'unitPrice': unitPrice,
        'discountPercent': discountPercent,
      };
}

/// DTO for creating a sale.
/// Supports multiple payment methods (split payments).
class CreateSaleDto {
  final String branchId;
  final String? customerId;
  final String cashierId;
  final String? cashSessionId;
  final List<SaleItemDto> items;
  final List<PaymentDto> payments;
  final double? discountAmount;
  final String? notes;

  const CreateSaleDto({
    required this.branchId,
    this.customerId,
    required this.cashierId,
    this.cashSessionId,
    required this.items,
    required this.payments,
    this.discountAmount,
    this.notes,
  });

  /// Convenience constructor for single payment method.
  factory CreateSaleDto.singlePayment({
    required String branchId,
    String? customerId,
    required String cashierId,
    String? cashSessionId,
    required List<SaleItemDto> items,
    required PaymentMethod paymentMethod,
    required double amount,
    double? discountAmount,
    String? notes,
  }) {
    return CreateSaleDto(
      branchId: branchId,
      customerId: customerId,
      cashierId: cashierId,
      cashSessionId: cashSessionId,
      items: items,
      payments: [PaymentDto(method: paymentMethod, amount: amount)],
      discountAmount: discountAmount,
      notes: notes,
    );
  }

  /// Total amount from all payments.
  double get totalPayments => payments.fold(0, (sum, p) => sum + p.amount);

  /// Total amount from items.
  double get itemsSubtotal =>
      items.fold(0.0, (sum, item) => sum + item.subtotal);

  /// Validates that payments cover the total.
  bool get paymentsValid {
    final total = itemsSubtotal * 1.19 - (discountAmount ?? 0); // With 19% IVA
    return totalPayments >= total;
  }

  Map<String, dynamic> toJson() => {
        'branchId': branchId,
        'customerId': customerId,
        'cashierId': cashierId,
        'cashSessionId': cashSessionId,
        'items': items.map((i) => i.toJson()).toList(),
        'payments': payments.map((p) => p.toJson()).toList(),
        'discountAmount': discountAmount,
        'notes': notes,
      };
}
