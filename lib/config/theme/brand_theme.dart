import 'package:flutter/material.dart';

/// Centralized design tokens. The only place where raw design values live.
class BrandColors {
  BrandColors._();

  // Light palette (DESIGN.md 2.1).
  static const Color lightBgBase = Color(0xFFFFFFFF);
  static const Color lightBgSurface = Color(0xFFFFFFFF);
  static const Color lightBgElevated = Color(0xFFEDEDED);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF3F3F46);
  static const Color lightPrimary = Color(0xFF0033CC);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightSuccess = Color(0xFF166534);
  static const Color lightWarning = Color(0xFF92400E);
  static const Color lightError = Color(0xFFB91C1C);
  static const Color lightBorder = Color(0xFF111111);
  static const Color lightBorderSubtle = Color(0x66111111);
  static const Color lightNavSurface = Color(0xEBFFFFFF);
  static const Color lightFocusRing = Color(0xFF0033CC);

  // Dark palette (DESIGN.md 2.1).
  static const Color darkBgBase = Color(0xFF000000);
  static const Color darkBgSurface = Color(0xFF121212);
  static const Color darkBgElevated = Color(0xFF1C1C1C);
  static const Color darkTextPrimary = Color(0xFFF2F4F7);
  static const Color darkTextSecondary = Color(0xFFAAABAD);
  // Muted blue: the single dark accent, same identity as light #0033CC.
  static const Color darkPrimary = Color(0xFF8AA8FF);
  static const Color darkOnPrimary = Color(0xFF0A1433);
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkWarning = Color(0xFFFACC15);
  static const Color darkError = Color(0xFFF87171);
  static const Color darkBorder = Color(0xFF3F3F46);
  static const Color darkBorderSubtle = Color(0x663F3F46);
  static const Color darkNavSurface = Color(0xEB000000);
  static const Color darkFocusRing = darkPrimary;
}

/// Palette of the optional terminal easter egg (DESIGN.md 3.8).
///
/// Scoped to `TerminalLandingPage`: the portfolio itself never uses these.
class TerminalColors {
  TerminalColors._();

  static const Color bgBase = Color(0xFF000000);
  static const Color bgSurface = Color(0xFF121212);
  static const Color bgElevated = Color(0xFF1C1C1C);
  static const Color textPrimary = Color(0xFFF2F4F7);
  static const Color textSecondary = Color(0xFFAAABAD);
  static const Color green = Color(0xFF4ADE80);
  static const Color onGreen = Color(0xFF052E16);
  static const Color cyan = Color(0xFF56D4DD);
  static const Color yellow = Color(0xFFE3C667);
  static const Color magenta = Color(0xFFD2A8FF);
  static const Color red = Color(0xFFF87171);
  static const Color amber = Color(0xFFFACC15);
  static const Color scanline = Color(0x0D4ADE80);
  static const Color border = Color(0xFF264A33);
  static const Color borderSubtle = Color(0x66264A33);
  static const Color navSurface = Color(0xEB000000);
}

class BrandTheme {
  BrandTheme._();

  // Radii (DESIGN.md 2.4).
  static const double radiusSM = 0;
  static const double radius = 10;
  static const double radiusLG = 16;
  static const double radiusFull = 9999;

  // Spacing (DESIGN.md 2.3).
  static const double spaceXS = 4;
  static const double spaceSM = 8;
  static const double spaceMD = 16;
  static const double spaceLG = 24;
  static const double spaceXL = 32;
  static const double space2XL = 48;

  // Layout.
  static const double contentMaxWidth = 1200;
  static const double gutterDesktop = 80;
  static const double gutterMobile = 24;
  static const double sectionVertical = 96;
  static const double headerHeight = 80;
  static const double controlHeight = 40;
  static const double controlHeightLG = 48;

  // Bundled families (DESIGN.md 2.2).
  static const String fontFamily = 'Poppins';
  static const String monoFamily = 'JetBrainsMono';
}

class BrandTextStyles {
  BrandTextStyles._();

  static TextStyle mono({
    double fontSize = 12,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double letterSpacing = 0.4,
    double height = 1.4,
  }) {
    return TextStyle(
      fontFamily: BrandTheme.monoFamily,
      fontSize: fontSize,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      height: height,
      color: color,
    );
  }
}
