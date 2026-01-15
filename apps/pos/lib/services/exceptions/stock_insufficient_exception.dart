/// Exception thrown when stock is insufficient for a sale.
class StockInsufficientException implements Exception {
  final String variantId;
  final double available;
  final double required;
  final String branchId;

  StockInsufficientException({
    required this.variantId,
    required this.available,
    required this.required,
    required this.branchId,
  });

  double get missing => required - available;

  @override
  String toString() {
    return 'Stock insuficiente. Disponible: $available, Requerido: $required, Faltante: $missing';
  }

  Map<String, dynamic> toJson() => {
    'error': 'STOCK_INSUFFICIENT',
    'variantId': variantId,
    'available': available,
    'required': required,
    'missing': missing,
    'branchId': branchId,
  };
}
