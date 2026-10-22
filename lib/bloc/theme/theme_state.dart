part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({this.mode = ThemeMode.light});

  final ThemeMode mode;

  bool get isDark => mode == ThemeMode.dark;

  ThemeState copyWith({ThemeMode? mode}) {
    return ThemeState(mode: mode ?? this.mode);
  }

  @override
  List<Object?> get props => [mode];
}
