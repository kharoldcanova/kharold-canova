import 'package:flutter/material.dart';

class BrandColors {
  BrandColors._();

  static const Color primary = Color(0xFF3917C0);
  static const Color primaryBg = Color(0xFF1A0A4A);
  static const Color primaryHover = Color(0xFF5B3DD8);
  static const Color primaryActive = Color(0xFF2A0F90);
  static const Color primaryText = Color(0xFFB8A6FF);

  static const Color success = Color(0xFF52C41A);
  static const Color successBg = Color(0xFFF6FFED);
  static const Color warning = Color(0xFFFAAD14);
  static const Color warningBg = Color(0xFFFFFBE6);
  static const Color error = Color(0xFFFF4D4F);
  static const Color errorBg = Color(0xFFFFF2F0);

  static const Color text = Color(0xFFF0F0F0);
  static const Color textSecondary = Color(0xFFA6A6A6);
  static const Color textTertiary = Color(0xFF8C8C8C);
  static const Color textQuaternary = Color(0xFF595959);

  static const Color fill = Color(0xFF333333);
  static const Color fillSecondary = Color(0xFF262626);
  static const Color fillTertiary = Color(0xFF1A1A1A);
  static const Color fillQuaternary = Color(0xFF141414);

  static const Color bgLayout = Color(0xFF000000);
  static const Color bgContainer = Color(0xFF0D0D0D);
  static const Color border = Color(0xFF333333);
  static const Color borderSecondary = Color(0xFF262626);
}

class BrandTheme {
  BrandTheme._();

  static const double radiusXS = 3;
  static const double radiusSM = 5;
  static const double radius = 8;
  static const double radiusLG = 10;
  static const double controlHeight = 32;
  static const double controlHeightLG = 40;

  static const double sizeXS = 8;
  static const double sizeSM = 12;
  static const double size = 16;
  static const double sizeMD = 20;
  static const double sizeLG = 24;
  static const double sizeXL = 32;
  static const double sizeXXL = 48;

  static ThemeData get light => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        scaffoldBackgroundColor: BrandColors.bgLayout,
        colorScheme: const ColorScheme.light(
          primary: BrandColors.primary,
          onPrimary: Colors.white,
          secondary: BrandColors.primary,
          onSecondary: Colors.white,
          error: BrandColors.error,
          onError: Colors.white,
          surface: BrandColors.bgContainer,
          onSurface: BrandColors.text,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: BrandColors.bgContainer,
          foregroundColor: BrandColors.text,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: BrandColors.bgContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            side: const BorderSide(color: BrandColors.borderSecondary, width: 1),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: BrandColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: size),
            minimumSize: const Size(0, controlHeight),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: BrandColors.text,
            side: const BorderSide(color: BrandColors.border),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: size),
            minimumSize: const Size(0, controlHeight),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: BrandColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: size),
            minimumSize: const Size(0, controlHeight),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: sizeSM,
            vertical: 0,
          ),
          isDense: true,
          constraints: const BoxConstraints(minHeight: controlHeight),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: BrandColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: BrandColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: BrandColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: BrandColors.error),
          ),
          labelStyle: const TextStyle(
            fontSize: 12,
            color: BrandColors.textSecondary,
          ),
          hintStyle: const TextStyle(
            fontSize: 14,
            color: BrandColors.textQuaternary,
          ),
          fillColor: BrandColors.bgContainer,
          filled: true,
        ),
        dividerColor: BrandColors.borderSecondary,
        dividerTheme: const DividerThemeData(
          color: BrandColors.borderSecondary,
          thickness: 1,
          space: size,
        ),
      );
}
