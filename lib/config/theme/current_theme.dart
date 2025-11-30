import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  List<Color> colors = [
    Colors.deepOrange,
    Colors.blueAccent[700]!,
    Colors.redAccent[400]!,
    Colors.deepPurple,
  ];

  Color getRandomColor() {
    return colors[Random().nextInt(colors.length)];
  }

  ThemeData getTheme() => ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: getRandomColor(),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: GoogleFonts.poppinsTextTheme());
}
