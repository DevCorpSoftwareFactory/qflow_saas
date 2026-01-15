import '../../data/local/database.dart';

/// DTO for creating a sale item
class SaleItemDto {
  final String variantId;
  final String? lotId;
  final int quantity;
  final double unitPrice;
  final double? discountPercent;

  SaleItemDto({
    required this.variantId,
    this.lotId,
    required this.quantity,
    required this.unitPrice,
    this.discountPercent,
  });
}

/// DTO for creating a sale
class CreateSaleDto {
  final String branchId;
  final String? customerId;
  final String cashierId;
  final String? cashSessionId;
  final List<SaleItemDto> items;
  final PaymentMethod paymentMethod;
  final double? discountAmount;

  CreateSaleDto({
    required this.branchId,
    this.customerId,
    required this.cashierId,
    this.cashSessionId,
    required this.items,
    required this.paymentMethod,
    this.discountAmount,
  });
}
