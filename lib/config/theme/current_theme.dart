import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';

class AppTheme {
  ThemeData getTheme() => _build(_Palette.light);

  ThemeData getDarkTheme() => _build(_Palette.dark);

  /// Theme of the optional terminal easter egg; independent of the app mode.
  ThemeData getTerminalTheme() => _build(_Palette.terminal);

  ThemeData _build(_Palette palette) {
    final brightness = palette.brightness;
    final bgBase = palette.bgBase;
    final bgSurface = palette.bgSurface;
    final bgElevated = palette.bgElevated;
    final textPrimary = palette.textPrimary;
    final textSecondary = palette.textSecondary;
    final primary = palette.primary;
    final onPrimary = palette.onPrimary;
    final error = palette.error;
    final border = palette.border;
    final borderSubtle = palette.borderSubtle;
    final focusRing = palette.focusRing;
    final navSurface = palette.navSurface;
    final tokens = palette.tokens;

    const baseTextTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.w500,
        height: 1,
        letterSpacing: -1.6,
      ),
      displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w500,
        height: 1.05,
        letterSpacing: -1,
      ),
      displaySmall: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w400,
        height: 1.1,
        letterSpacing: -0.5,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );

    final fontFamily = palette.fontFamily;
    final textTheme = baseTextTheme.apply(
      fontFamily: fontFamily,
      bodyColor: textPrimary,
      displayColor: textPrimary,
    );

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: bgElevated,
      onPrimaryContainer: textPrimary,
      secondary: primary,
      onSecondary: onPrimary,
      secondaryContainer: bgElevated,
      onSecondaryContainer: textPrimary,
      // One accent per mode (DESIGN.md 2.1): tertiary mirrors primary.
      tertiary: primary,
      onTertiary: onPrimary,
      error: error,
      onError: Colors.white,
      surface: bgSurface,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      surfaceContainerHighest: bgElevated,
      outline: border,
      outlineVariant: borderSubtle,
      shadow: Colors.transparent,
      scrim: Colors.black,
      inverseSurface: textPrimary,
      onInverseSurface: bgBase,
      inversePrimary: primary,
    );

    return ThemeData(
      useMaterial3: false,
      brightness: brightness,
      scaffoldBackgroundColor: bgBase,
      canvasColor: bgBase,
      colorScheme: colorScheme,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: IconThemeData(color: textPrimary, size: 20),
      dividerColor: borderSubtle,
      focusColor: focusRing.withValues(alpha: 0.16),
      hoverColor: primary.withValues(alpha: 0.06),
      highlightColor: primary.withValues(alpha: 0.08),
      splashColor: primary.withValues(alpha: 0.08),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: bgSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
          side: BorderSide(color: border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: primary.withValues(alpha: 0.5),
          disabledForegroundColor: onPrimary.withValues(alpha: 0.7),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: BrandTheme.spaceLG,
            vertical: BrandTheme.spaceSM,
          ),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          disabledForegroundColor: textPrimary.withValues(alpha: 0.5),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          side: BorderSide(color: border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: BrandTheme.spaceLG,
            vertical: BrandTheme.spaceSM,
          ),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: BrandTheme.spaceMD,
            vertical: BrandTheme.spaceSM,
          ),
          minimumSize: const Size(0, BrandTheme.controlHeight),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: BrandTheme.spaceMD,
          vertical: BrandTheme.spaceSM,
        ),
        isDense: true,
        constraints: const BoxConstraints(minHeight: BrandTheme.controlHeight),
        filled: true,
        fillColor: bgSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: BorderSide(color: focusRing, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          borderSide: BorderSide(color: error, width: 2),
        ),
        labelStyle: TextStyle(fontSize: 12, color: textSecondary),
        hintStyle: TextStyle(
          fontSize: 14,
          color: textSecondary.withValues(alpha: 0.7),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: borderSubtle,
        thickness: 1,
        space: BrandTheme.spaceLG,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: bgElevated,
          borderRadius: BorderRadius.circular(BrandTheme.radius),
          border: Border.all(color: borderSubtle),
        ),
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          color: textPrimary,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          textSecondary.withValues(alpha: 0.5),
        ),
        thickness: const WidgetStatePropertyAll(8),
        radius: const Radius.circular(BrandTheme.radiusFull),
      ),
      extensions: <ThemeExtension<dynamic>>[
        tokens.copyWith(
          navSurface: navSurface,
          focusRing: focusRing,
          borderSubtle: borderSubtle,
          elevated: bgElevated,
        ),
      ],
    );
  }
}

/// Raw values for one theme variant; every value comes from brand_theme.dart.
class _Palette {
  const _Palette({
    required this.brightness,
    required this.bgBase,
    required this.bgSurface,
    required this.bgElevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.onPrimary,
    required this.error,
    required this.border,
    required this.borderSubtle,
    required this.focusRing,
    required this.navSurface,
    required this.fontFamily,
    required this.tokens,
  });

  final Brightness brightness;
  final Color bgBase;
  final Color bgSurface;
  final Color bgElevated;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color onPrimary;
  final Color error;
  final Color border;
  final Color borderSubtle;
  final Color focusRing;
  final Color navSurface;
  final String fontFamily;
  final PortfolioTokens tokens;

  static const light = _Palette(
    brightness: Brightness.light,
    bgBase: BrandColors.lightBgBase,
    bgSurface: BrandColors.lightBgSurface,
    bgElevated: BrandColors.lightBgElevated,
    textPrimary: BrandColors.lightTextPrimary,
    textSecondary: BrandColors.lightTextSecondary,
    primary: BrandColors.lightPrimary,
    onPrimary: BrandColors.lightOnPrimary,
    error: BrandColors.lightError,
    border: BrandColors.lightBorder,
    borderSubtle: BrandColors.lightBorderSubtle,
    focusRing: BrandColors.lightFocusRing,
    navSurface: BrandColors.lightNavSurface,
    fontFamily: BrandTheme.fontFamily,
    tokens: PortfolioTokens.light,
  );

  static const dark = _Palette(
    brightness: Brightness.dark,
    bgBase: BrandColors.darkBgBase,
    bgSurface: BrandColors.darkBgSurface,
    bgElevated: BrandColors.darkBgElevated,
    textPrimary: BrandColors.darkTextPrimary,
    textSecondary: BrandColors.darkTextSecondary,
    primary: BrandColors.darkPrimary,
    onPrimary: BrandColors.darkOnPrimary,
    error: BrandColors.darkError,
    border: BrandColors.darkBorder,
    borderSubtle: BrandColors.darkBorderSubtle,
    focusRing: BrandColors.darkFocusRing,
    navSurface: BrandColors.darkNavSurface,
    fontFamily: BrandTheme.fontFamily,
    tokens: PortfolioTokens.dark,
  );

  static const terminal = _Palette(
    brightness: Brightness.dark,
    bgBase: TerminalColors.bgBase,
    bgSurface: TerminalColors.bgSurface,
    bgElevated: TerminalColors.bgElevated,
    textPrimary: TerminalColors.textPrimary,
    textSecondary: TerminalColors.textSecondary,
    primary: TerminalColors.green,
    onPrimary: TerminalColors.onGreen,
    error: TerminalColors.red,
    border: TerminalColors.border,
    borderSubtle: TerminalColors.borderSubtle,
    focusRing: TerminalColors.green,
    navSurface: TerminalColors.navSurface,
    fontFamily: BrandTheme.monoFamily,
    tokens: PortfolioTokens.dark,
  );
}
