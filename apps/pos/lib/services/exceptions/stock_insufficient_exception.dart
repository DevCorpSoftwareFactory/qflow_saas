/// Exception thrown when stock is insufficient for a sale.
class StockInsufficientException implements Exception {
  final String variantId;
  final double available;
  final double required;
  final String branchId;
  final String? reason;

  StockInsufficientException({
    required this.variantId,
    required this.available,
    required this.required,
    required this.branchId,
    this.reason,
  });

  double get missing => required - available;

  @override
  String toString() {
    if (reason != null) {
      return 'Stock insuficiente: $reason. Disponible: $available, Requerido: $required';
    }
    return 'Stock insuficiente. Disponible: $available, Requerido: $required, Faltante: $missing';
  }

  Map<String, dynamic> toJson() => {
        'error': 'STOCK_INSUFFICIENT',
        'variantId': variantId,
        'available': available,
        'required': required,
        'missing': missing,
        'branchId': branchId,
        'reason': reason,
      };
}
