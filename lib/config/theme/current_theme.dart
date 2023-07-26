import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.blueAccent[700]!,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme());
}
