import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Events
abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class AppThemeChanged extends AppEvent {
  final ThemeMode themeMode;
  const AppThemeChanged(this.themeMode);
}

// State
class AppState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const AppState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('es'),
  });

  AppState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object> get props => [themeMode, locale];
}

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<AppStarted>((event, emit) async {
      // Load stored preferences here if needed
    });

    on<AppThemeChanged>((event, emit) {
      emit(state.copyWith(themeMode: event.themeMode));
    });
  }
}
