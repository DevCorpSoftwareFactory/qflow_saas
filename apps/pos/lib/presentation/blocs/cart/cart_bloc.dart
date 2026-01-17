import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos/services/hardware/hardware_service.dart';
import 'package:pos/services/hardware/receipt_generator.dart';
import '../../../data/dto/product_variant_view.dart';
import '../../../services/sales_service.dart';
import '../../../services/dto/create_sale_dto.dart';
import '../../../data/local/tables/enums.dart';

// --- Events ---
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  final ProductVariantView product;
  final int quantity;
  const CartItemAdded(this.product, {this.quantity = 1});
  @override
  List<Object?> get props => [product, quantity];
}

class CartItemRemoved extends CartEvent {
  final String variantId;
  const CartItemRemoved(this.variantId);
  @override
  List<Object?> get props => [variantId];
}

class CartCleared extends CartEvent {}

class CartPromotionApplied extends CartEvent {
  final String promoCode;
  const CartPromotionApplied(this.promoCode);
  @override
  List<Object?> get props => [promoCode];
}

/// Checkout event with support for multiple payment methods.
class CartCheckoutRequested extends CartEvent {
  final String userId;
  final String tenantId;
  final String branchId;
  final List<PaymentDto> payments; // Multiple payments support
  final String? cashSessionId;
  final String tenantName;
  final String branchName;
  final String cashierName;

  const CartCheckoutRequested({
    required this.userId,
    required this.tenantId,
    required this.branchId,
    required this.payments,
    this.cashSessionId,
    this.tenantName = 'QFlow Store',
    this.branchName = 'Main Branch',
    this.cashierName = 'Cashier',
  });

  /// Convenience constructor for single payment.
  factory CartCheckoutRequested.single({
    required String userId,
    required String tenantId,
    required String branchId,
    required PaymentMethod method,
    required double amount,
    String? cashSessionId,
    String tenantName = 'QFlow Store',
    String branchName = 'Main Branch',
    String cashierName = 'Cashier',
  }) {
    return CartCheckoutRequested(
      userId: userId,
      tenantId: tenantId,
      branchId: branchId,
      payments: [PaymentDto(method: method, amount: amount)],
      cashSessionId: cashSessionId,
      tenantName: tenantName,
      branchName: branchName,
      cashierName: cashierName,
    );
  }

  double get totalPayments => payments.fold(0, (sum, p) => sum + p.amount);

  @override
  List<Object?> get props => [
        userId,
        tenantId,
        branchId,
        payments,
        cashSessionId,
        tenantName,
        branchName,
        cashierName,
      ];
}

// --- State ---
enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final List<CartItem> items;
  final double subtotal; // Items total before discount
  final double discountAmount;
  final double taxAmount; // IVA 19%
  final double total; // Final total with tax
  final int itemsCount;
  final CartStatus status;
  final String? errorMessage;
  final String? promoCode;
  final SaleResult? lastSaleResult; // Last completed sale for receipt

  const CartState({
    this.items = const [],
    this.subtotal = 0,
    this.discountAmount = 0,
    this.taxAmount = 0,
    this.total = 0,
    this.itemsCount = 0,
    this.status = CartStatus.initial,
    this.errorMessage,
    this.promoCode,
    this.lastSaleResult,
  });

  CartState copyWith({
    List<CartItem>? items,
    CartStatus? status,
    String? errorMessage,
    double? discountAmount,
    String? promoCode,
    bool clearPromo = false,
    SaleResult? lastSaleResult,
    bool clearLastSale = false,
  }) {
    final newItems = items ?? this.items;
    final newStatus = status ?? this.status;
    final newPromoCode = clearPromo ? null : (promoCode ?? this.promoCode);

    // 1. Calculate Subtotal
    double newSubtotal = 0;
    int newCount = 0;
    for (var item in newItems) {
      newSubtotal += item.product.price * item.quantity;
      newCount += item.quantity;
    }

    // 2. Calculate Discount
    double newDiscountAmount =
        clearPromo ? 0 : (discountAmount ?? this.discountAmount);

    // Prevent negative
    if (newDiscountAmount > newSubtotal) {
      newDiscountAmount = newSubtotal;
    }

    // 3. Calculate Tax (19% IVA Colombia)
    final taxableAmount = newSubtotal - newDiscountAmount;
    final newTaxAmount = taxableAmount * 0.19;

    // 4. Final Total
    final newTotal = taxableAmount + newTaxAmount;

    return CartState(
      items: newItems,
      subtotal: newSubtotal,
      discountAmount: newDiscountAmount,
      taxAmount: newTaxAmount,
      total: newTotal,
      itemsCount: newCount,
      status: newStatus,
      errorMessage: errorMessage,
      promoCode: newPromoCode,
      lastSaleResult:
          clearLastSale ? null : (lastSaleResult ?? this.lastSaleResult),
    );
  }

  @override
  List<Object?> get props => [
        items,
        subtotal,
        discountAmount,
        taxAmount,
        total,
        itemsCount,
        status,
        errorMessage,
        promoCode,
        lastSaleResult,
      ];
}

class CartItem extends Equatable {
  final ProductVariantView product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  double get subtotal => product.price * quantity;

  @override
  List<Object?> get props => [product, quantity];
}

// --- Bloc ---
class CartBloc extends Bloc<CartEvent, CartState> {
  final SalesService _salesService;
  final HardwareService _hardwareService;
  final ReceiptGenerator _receiptGenerator;

  CartBloc(this._salesService, this._hardwareService, this._receiptGenerator)
      : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>(_onCleared);
    on<CartPromotionApplied>(_onPromotionApplied);
    on<CartCheckoutRequested>(_onCheckoutRequested);
  }

  void _onPromotionApplied(
      CartPromotionApplied event, Emitter<CartState> emit) {
    if (state.items.isEmpty) return;

    // Simple Promotion Logic for Demo
    double discount = 0;
    String code = event.promoCode.toUpperCase();

    // Calculate current subtotal first to apply percentage
    double subtotal = 0;
    for (var item in state.items) {
      subtotal += item.product.price * item.quantity;
    }

    if (code == 'PROMO10') {
      discount = subtotal * 0.10; // 10%
    } else if (code == 'PROMO50') {
      discount = 50.0; // Flat $50
    } else if (code == 'CLEAR') {
      emit(state.copyWith(clearPromo: true));
      return;
    } else {
      emit(state.copyWith(
          status: CartStatus.failure, errorMessage: 'Invalid Promo Code'));
      // Reset status to initial immediate so error doesn't stick
      emit(state.copyWith(status: CartStatus.initial));
      return;
    }

    emit(state.copyWith(
      promoCode: code,
      discountAmount: discount,
      status: CartStatus.initial,
    ));
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    // Reset status on modification
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (i) => i.product.variantId == event.product.variantId,
    );

    if (index >= 0) {
      final newQuantity = currentItems[index].quantity + event.quantity;
      if (newQuantity <= 0) {
        currentItems.removeAt(index);
      } else {
        currentItems[index] = currentItems[index].copyWith(
          quantity: newQuantity,
        );
      }
    } else if (event.quantity > 0) {
      currentItems.add(
        CartItem(product: event.product, quantity: event.quantity),
      );
    }

    emit(state.copyWith(items: currentItems, status: CartStatus.initial));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((i) => i.product.variantId == event.variantId);
    emit(state.copyWith(items: currentItems, status: CartStatus.initial));
  }

  void _onCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState(status: CartStatus.initial));
  }

  Future<void> _onCheckoutRequested(
    CartCheckoutRequested event,
    Emitter<CartState> emit,
  ) async {
    if (state.items.isEmpty) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: 'Cart is empty',
        ),
      );
      return;
    }

    // Validate payments cover total
    if (event.totalPayments < state.total) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage:
              'Payment amount insufficient. Need \$${state.total.toStringAsFixed(0)}, got \$${event.totalPayments.toStringAsFixed(0)}',
        ),
      );
      return;
    }

    emit(state.copyWith(status: CartStatus.loading));

    try {
      // Map CartItems to SaleItemDto
      final saleItems = state.items.map((i) {
        return SaleItemDto(
          variantId: i.product.variantId,
          quantity: i.quantity,
          unitPrice: i.product.price,
          productName: i.product.productName, // For receipt
        );
      }).toList();

      final dto = CreateSaleDto(
        branchId: event.branchId,
        cashierId: event.userId,
        cashSessionId: event.cashSessionId,
        items: saleItems,
        payments: event.payments,
        discountAmount: state.discountAmount,
      );

      // Create sale with FIFO consumption
      final saleResult = await _salesService.createSale(dto, event.tenantId);

      // Generate and print receipt
      try {
        final receiptBytes = await _receiptGenerator.generateReceiptFromResult(
          saleResult: saleResult,
          payments: event.payments,
          tenantName: event.tenantName,
          branchName: event.branchName,
          cashierName: event.cashierName,
          change: event.totalPayments - state.total,
        );

        // Fire and forget print
        _hardwareService.printReceipt(receiptBytes).catchError((e) {
          // Log error silently
        });

        // Open drawer for cash payments
        if (event.payments.any((p) => p.method == PaymentMethod.cash)) {
          _hardwareService.openDrawer().catchError((e) {
            // Log error silently
          });
        }
      } catch (e) {
        // Hardware error - don't fail the sale
      }

      emit(state.copyWith(
        status: CartStatus.success,
        lastSaleResult: saleResult,
      ));

      // Clear cart after successful checkout
      add(CartCleared());
    } catch (e) {
      emit(
        state.copyWith(
          status: CartStatus.failure,
          errorMessage: 'Checkout failed: $e',
        ),
      );
    }
  }
}
