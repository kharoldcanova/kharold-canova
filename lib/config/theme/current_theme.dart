import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';

class AppTheme {
  ThemeData getTheme() => _buildLight();

  ThemeData getDarkTheme() => _buildDark();

  ThemeData _buildLight() {
    final textTheme = GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    );
    final brand = BrandTheme.light;

    return brand.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      appBarTheme: brand.appBarTheme.copyWith(
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BrandColors.text,
        ),
      ),
    );
  }

  ThemeData _buildDark() {
    const primary = Color(0xFF8B6DF0);
    const text = Color(0xFFF0F0F0);
    const textSecondary = Color(0xFFA6A6A6);
    const bgLayout = Color(0xFF000000);
    const bgContainer = Color(0xFF0D0D0D);
    const border = Color(0xFF333333);
    const borderSecondary = Color(0xFF262626);

    final textTheme = GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    );

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgLayout,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        onPrimary: Colors.white,
        secondary: primary,
        onSecondary: Colors.white,
        error: Color(0xFFFF7875),
        onError: Colors.white,
        surface: bgContainer,
        onSurface: text,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgContainer,
        foregroundColor: text,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
      cardTheme: CardThemeData(
        color: bgContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
          side: const BorderSide(color: borderSecondary, width: 1),
        ),
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: BrandTheme.size),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          side: const BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: BrandTheme.size),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: BrandTheme.size),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: BrandTheme.sizeSM,
          vertical: 0,
        ),
        isDense: true,
        constraints: const BoxConstraints(minHeight: BrandTheme.controlHeight),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: const BorderSide(color: primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: const BorderSide(color: Color(0xFFFF7875)),
        ),
        labelStyle: const TextStyle(fontSize: 12, color: textSecondary),
        hintStyle: TextStyle(
          fontSize: 14,
          color: textSecondary.withAlpha(128),
        ),
        fillColor: bgContainer,
        filled: true,
      ),
      dividerColor: borderSecondary,
      dividerTheme: const DividerThemeData(
        color: borderSecondary,
        thickness: 1,
        space: BrandTheme.size,
      ),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
    );
  }
}
