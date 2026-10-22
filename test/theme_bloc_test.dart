import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('a first visit without a stored choice is light', () async {
    expect(await ThemePreferences.load(), ThemeMode.light);
  });

  test('a stored dark choice is restored', () async {
    SharedPreferences.setMockInitialValues(
      <String, Object>{ThemePreferences.storageKey: 'dark'},
    );
    expect(await ThemePreferences.load(), ThemeMode.dark);
  });

  test('toggling moves only between light and dark and persists', () async {
    final bloc = ThemeBloc();
    addTearDown(bloc.close);

    expect(bloc.state.mode, ThemeMode.light);

    final darkState = bloc.stream.firstWhere(
      (state) => state.mode == ThemeMode.dark,
    );
    bloc.add(const ToggleTheme());
    await darkState;

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(ThemePreferences.storageKey), 'dark');

    final lightState = bloc.stream.firstWhere(
      (state) => state.mode == ThemeMode.light,
    );
    bloc.add(const ToggleTheme());
    await lightState;
    expect(prefs.getString(ThemePreferences.storageKey), 'light');
  });

  test('a system mode request is ignored', () async {
    final bloc = ThemeBloc();
    addTearDown(bloc.close);

    bloc.add(const SetThemeMode(ThemeMode.system));
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.mode, ThemeMode.light);
  });
}
