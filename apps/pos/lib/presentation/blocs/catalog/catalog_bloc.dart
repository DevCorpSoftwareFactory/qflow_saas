import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_bus/event_bus.dart';
import '../../../services/catalog_service.dart';
import '../../../data/dto/product_variant_view.dart';
import '../../../core/events.dart';

// Events
abstract class CatalogEvent extends Equatable {
  const CatalogEvent();
  @override
  List<Object> get props => [];
}

class CatalogLoadStarted extends CatalogEvent {}

class CatalogRefreshed extends CatalogEvent {}

class CatalogSearchChanged extends CatalogEvent {
  final String query;
  const CatalogSearchChanged(this.query);
}

// State
abstract class CatalogState extends Equatable {
  const CatalogState();
  @override
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<ProductVariantView> items;

  const CatalogLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class CatalogError extends CatalogState {
  final String message;
  const CatalogError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogService _catalogService;
  final EventBus _eventBus;
  late StreamSubscription _busSubscription;
  List<ProductVariantView> _allItems = [];

  CatalogBloc(this._catalogService, this._eventBus) : super(CatalogInitial()) {
    on<CatalogLoadStarted>(_onLoadStarted);
    on<CatalogRefreshed>(_onRefreshed);
    on<CatalogSearchChanged>(_onSearchChanged);

    // Listen to EventBus
    _busSubscription = _eventBus.on().listen((event) {
      if (event is CatalogUpdatedEvent) {
        add(CatalogLoadStarted());
      } else if (event is AuthStateChangedEvent && event.isAuthenticated) {
        add(CatalogRefreshed());
      }
    });
  }

  @override
  Future<void> close() {
    _busSubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadStarted(
    CatalogLoadStarted event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      final items = await _catalogService.getSellableVariants();
      _allItems = items;
      emit(CatalogLoaded(items));
    } catch (e) {
      emit(CatalogError('Failed to load catalog: $e'));
    }
  }

  Future<void> _onRefreshed(
    CatalogRefreshed event,
    Emitter<CatalogState> emit,
  ) async {
    emit(CatalogLoading());
    try {
      // Trigger sync
      await _catalogService.syncAll();
      // Reload local data
      final items = await _catalogService.getSellableVariants();
      _allItems = items;
      emit(CatalogLoaded(items));
    } catch (e) {
      emit(CatalogError('Sync failed: $e'));
    }
  }

  Future<void> _onSearchChanged(
    CatalogSearchChanged event,
    Emitter<CatalogState> emit,
  ) async {
    final query = event.query.toLowerCase();

    emit(CatalogLoading());

    try {
      if (query.isEmpty) {
        // If empty, revert to default view (all items)
        if (_allItems.isNotEmpty) {
          emit(CatalogLoaded(_allItems));
        } else {
          // Reload defaults if cache is empty
          add(CatalogLoadStarted());
        }
        return;
      }

      final results = await _catalogService.searchProducts(query);
      emit(CatalogLoaded(results));
    } catch (e) {
      emit(CatalogError('Search failed: $e'));
    }
  }
}
