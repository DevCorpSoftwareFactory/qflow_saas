import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/local/database.dart';
import '../../../../data/sync/sync_service.dart';

// Events
abstract class SyncEvent extends Equatable {
  const SyncEvent();
  @override
  List<Object> get props => [];
}

class LoadConflicts extends SyncEvent {}

class ResolveConflict extends SyncEvent {
  final int conflictId;
  final bool keepLocal; // true = Client Wins, false = Server Wins

  const ResolveConflict(this.conflictId, this.keepLocal);

  @override
  List<Object> get props => [conflictId, keepLocal];
}

class RunSync extends SyncEvent {}

// State
abstract class SyncState extends Equatable {
  const SyncState();
  @override
  List<Object> get props => [];
}

class SyncInitial extends SyncState {}

class SyncLoading extends SyncState {}

class SyncLoaded extends SyncState {
  final List<SyncConflict> conflicts;
  final int pendingCount;
  final String? message;

  const SyncLoaded({
    required this.conflicts,
    required this.pendingCount,
    this.message,
  });

  @override
  List<Object> get props => [conflicts, pendingCount, message ?? ''];
}

class SyncError extends SyncState {
  final String message;
  const SyncError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncService _syncService;

  SyncBloc(this._syncService) : super(SyncInitial()) {
    on<LoadConflicts>(_onLoadConflicts);
    on<ResolveConflict>(_onResolveConflict);
    on<RunSync>(_onRunSync);
  }

  Future<void> _onLoadConflicts(
    LoadConflicts event,
    Emitter<SyncState> emit,
  ) async {
    emit(SyncLoading());
    try {
      final conflicts = await _syncService.getConflicts();
      final pendingRaw = await _syncService.getPendingSyncCount();
      emit(SyncLoaded(conflicts: conflicts, pendingCount: pendingRaw));
    } catch (e) {
      emit(SyncError(e.toString()));
    }
  }

  Future<void> _onResolveConflict(
    ResolveConflict event,
    Emitter<SyncState> emit,
  ) async {
    try {
      if (event.keepLocal) {
        await _syncService.resolveConflictKeepLocal(event.conflictId);
      } else {
        await _syncService.resolveConflictKeepRemote(event.conflictId);
      }
      add(LoadConflicts()); // Reload
    } catch (e) {
      emit(SyncError('Error resolving conflict: $e'));
    }
  }

  Future<void> _onRunSync(RunSync event, Emitter<SyncState> emit) async {
    // Optimistic update? No, simple status
    try {
      await _syncService.processSyncQueue();
      add(LoadConflicts()); // Refresh stats
    } catch (e) {
      emit(SyncError('Sync failed: $e'));
    }
  }
}
