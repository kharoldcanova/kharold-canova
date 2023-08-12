import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  List<Color> colors = [
    Colors.deepOrange,
    Colors.blueAccent[700]!,
    Colors.greenAccent[700]!,
    Colors.redAccent[400]!,
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
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.poppinsTextTheme());
}
