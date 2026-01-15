import 'package:equatable/equatable.dart';

/// detailed view of a product variant for UI presentation
/// composed of product details + variant specific details
class ProductVariantView extends Equatable {
  final String variantId;
  final String productId;
  final String sku;
  final String? barcode;
  final String productName;
  final String categoryName;
  final double price;
  final double? taxRate; // derived from tax info if available
  final bool trackInventory;
  final bool hasBatchControl;

  const ProductVariantView({
    required this.variantId,
    required this.productId,
    required this.sku,
    this.barcode,
    required this.productName,
    required this.categoryName,
    required this.price,
    this.taxRate,
    required this.trackInventory,
    required this.hasBatchControl,
  });

  String get displayName => '$productName ($sku)';

  @override
  List<Object?> get props => [
    variantId,
    productId,
    sku,
    barcode,
    productName,
    categoryName,
    price,
    taxRate,
    trackInventory,
    hasBatchControl,
  ];
}
