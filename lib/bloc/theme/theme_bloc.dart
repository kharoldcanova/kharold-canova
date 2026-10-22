import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharoldcanova/config/theme/theme_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeMode initialMode = ThemeMode.light})
      : super(ThemeState(mode: initialMode)) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final next =
        state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _apply(next, emit);
  }

  Future<void> _onSetThemeMode(
    SetThemeMode event,
    Emitter<ThemeState> emit,
  ) async {
    await _apply(event.mode, emit);
  }

  Future<void> _apply(ThemeMode mode, Emitter<ThemeState> emit) async {
    if (mode == state.mode || mode == ThemeMode.system) {
      return;
    }
    try {
      await ThemePreferences.save(mode);
    } catch (_) {
      // The in-memory choice still applies for this session.
    }
    emit(state.copyWith(mode: mode));
  }
}
