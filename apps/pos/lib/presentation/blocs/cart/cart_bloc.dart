import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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

class CartCheckoutRequested extends CartEvent {
  final String userId;
  final String tenantId;
  final String branchId;
  final String paymentMethod; // 'CASH', 'CARD', etc.
  final double amountTendered;

  const CartCheckoutRequested({
    required this.userId,
    required this.tenantId,
    required this.branchId,
    required this.paymentMethod,
    required this.amountTendered,
  });

  @override
  List<Object?> get props => [
    userId,
    tenantId,
    branchId,
    paymentMethod,
    amountTendered,
  ];
}

// --- State ---
enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final List<CartItem> items;
  final double total;
  final int itemsCount;
  final CartStatus status;
  final String? errorMessage;

  const CartState({
    this.items = const [],
    this.total = 0,
    this.itemsCount = 0,
    this.status = CartStatus.initial,
    this.errorMessage,
  });

  CartState copyWith({
    List<CartItem>? items,
    CartStatus? status,
    String? errorMessage,
  }) {
    // Recalculate totals whenever items change
    final newItems = items ?? this.items;
    double newTotal = 0;
    int newCount = 0;
    for (var item in newItems) {
      newTotal += item.product.price * item.quantity;
      newCount += item.quantity;
    }
    return CartState(
      items: newItems,
      total: newTotal,
      itemsCount: newCount,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [items, total, itemsCount, status, errorMessage];
}

class CartItem extends Equatable {
  final ProductVariantView product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }

  @override
  List<Object?> get props => [product, quantity];
}

// --- Bloc ---
class CartBloc extends Bloc<CartEvent, CartState> {
  final SalesService _salesService;

  CartBloc(this._salesService) : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>(_onCleared);
    on<CartCheckoutRequested>(_onCheckoutRequested);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    // Reset status on modification
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (i) => i.product.variantId == event.product.variantId,
    );

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + event.quantity,
      );
    } else {
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

    emit(state.copyWith(status: CartStatus.loading));

    try {
      // Map PaymentMethod
      final pm = PaymentMethod.values.firstWhere(
        (e) => e.name.toLowerCase() == event.paymentMethod.toLowerCase(),
        orElse: () => PaymentMethod.cash,
      );

      // Map CartItems to Input Items for Service
      final saleItems = state.items.map((i) {
        return SaleItemDto(
          variantId: i.product.variantId,
          quantity: i.quantity,
          unitPrice: i.product.price,
        );
      }).toList();

      final dto = CreateSaleDto(
        branchId: event.branchId,
        cashierId: event.userId,
        cashSessionId:
            null, // MVP: Logic for session handled by backend or null
        items: saleItems,
        paymentMethod: pm,
      );

      await _salesService.createSale(dto, event.tenantId);

      emit(state.copyWith(status: CartStatus.success));
      // Optionally clear cart after a delay or let UI trigger it
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
