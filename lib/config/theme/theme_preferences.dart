import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the owner's explicit theme choice. The first visit is always light.
class ThemePreferences {
  ThemePreferences._();

  static const String storageKey = 'theme_mode';
  static const String _dark = 'dark';
  static const String _light = 'light';

  static Future<ThemeMode> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(storageKey) == _dark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  static Future<void> save(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      storageKey,
      mode == ThemeMode.dark ? _dark : _light,
    );
  }
}
