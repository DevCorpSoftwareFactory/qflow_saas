import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched when the catalog (Categories, Products, etc.) is updated via Sync
class CatalogUpdatedEvent extends AppEvent {
  final DateTime timestamp;
  const CatalogUpdatedEvent(this.timestamp);

  @override
  List<Object?> get props => [timestamp];
}

/// Dispatched when stock levels change (e.g. sale completed, or inventory update)
class StockChangedEvent extends AppEvent {
  final String productVariantId;
  final double newQuantity;
  const StockChangedEvent(this.productVariantId, this.newQuantity);

  @override
  List<Object?> get props => [productVariantId, newQuantity];
}

/// Dispatched when authentication state changes
class AuthStateChangedEvent extends AppEvent {
  final bool isAuthenticated;
  const AuthStateChangedEvent(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}
