import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';

void main() {
  group('AppTheme light', () {
    late ThemeData theme;

    setUp(() {
      theme = AppTheme().getTheme();
    });

    test('uses the DESIGN.md light palette', () {
      expect(theme.brightness, Brightness.light);
      expect(theme.scaffoldBackgroundColor, const Color(0xFFFFFFFF));
      expect(theme.colorScheme.surface, const Color(0xFFFFFFFF));
      expect(theme.colorScheme.primary, const Color(0xFF0033CC));
      expect(theme.colorScheme.onPrimary, const Color(0xFFFFFFFF));
      expect(theme.colorScheme.outline, const Color(0xFF111111));
      expect(theme.colorScheme.outlineVariant, const Color(0x1F111111));
      expect(theme.colorScheme.onSurface, const Color(0xFF000000));
      expect(theme.colorScheme.onSurfaceVariant, const Color(0xFF3F3F46));
    });

    test('uses Poppins and the documented display sizes', () {
      expect(theme.textTheme.displayLarge?.fontFamily, BrandTheme.fontFamily);
      expect(theme.textTheme.displayLarge?.fontSize, 80);
      expect(theme.textTheme.displaySmall?.fontSize, 38);
      expect(theme.textTheme.headlineLarge?.fontSize, 32);
      expect(theme.textTheme.bodyLarge?.fontSize, 16);
    });

    test('uses radii 10 and 16 with no elevation', () {
      final cardShape = theme.cardTheme.shape! as RoundedRectangleBorder;
      expect(
        cardShape.borderRadius,
        BorderRadius.circular(BrandTheme.radiusLG),
      );
      expect(theme.cardTheme.elevation, 0);

      final buttonShape = theme.elevatedButtonTheme.style!.shape!
          .resolve(<WidgetState>{})! as RoundedRectangleBorder;
      expect(
        buttonShape.borderRadius,
        BorderRadius.circular(BrandTheme.radius),
      );
      expect(
        theme.elevatedButtonTheme.style!.elevation!.resolve(<WidgetState>{}),
        0,
      );
    });

    test('exposes the portfolio theme extension', () {
      final tokens = theme.extension<PortfolioTokens>();
      expect(tokens, isNotNull);
      expect(tokens!.contentMaxWidth, 1200);
      expect(tokens.navSurface, const Color(0xEBFFFFFF));
      expect(tokens.focusRing, const Color(0xFF0033CC));
    });
  });

  group('AppTheme dark', () {
    late ThemeData theme;

    setUp(() {
      theme = AppTheme().getDarkTheme();
    });

    test('uses the DESIGN.md dark palette and on-primary', () {
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, Colors.black);
      expect(theme.colorScheme.surface, const Color(0xFF121212));
      expect(theme.colorScheme.primary, const Color(0xFF8AA8FF));
      expect(theme.colorScheme.onPrimary, const Color(0xFF0A1433));
      expect(theme.colorScheme.outline, const Color(0xFF3F3F46));
      expect(theme.colorScheme.outlineVariant, const Color(0x1FF2F4F7));
      expect(theme.colorScheme.onSurface, const Color(0xFFF2F4F7));
      expect(theme.colorScheme.onSurfaceVariant, const Color(0xFFAAABAD));
    });

    test('uses the same sans family as light mode', () {
      expect(theme.textTheme.bodyLarge?.fontFamily, BrandTheme.fontFamily);
      expect(theme.textTheme.headlineLarge?.fontFamily, BrandTheme.fontFamily);
    });

    test('exposes the dark portfolio theme extension', () {
      final tokens = theme.extension<PortfolioTokens>();
      expect(tokens, isNotNull);
      expect(tokens!.navSurface, const Color(0xEB000000));
      expect(tokens.focusRing, const Color(0xFF8AA8FF));
      expect(tokens.borderSubtle, const Color(0x1FF2F4F7));
      expect(tokens.elevated, const Color(0xFF1C1C1C));
    });
  });

  group('One accent per mode', () {
    const terminalAccents = <Color>[
      TerminalColors.green,
      TerminalColors.cyan,
      TerminalColors.yellow,
      TerminalColors.magenta,
    ];

    for (final entry in <String, ThemeData Function()>{
      'light': () => AppTheme().getTheme(),
      'dark': () => AppTheme().getDarkTheme(),
    }.entries) {
      test('${entry.key} exposes a single accent and no terminal colors', () {
        final scheme = entry.value().colorScheme;
        final accents = <Color>{
          scheme.primary,
          scheme.secondary,
          scheme.tertiary,
          scheme.inversePrimary,
        };
        expect(accents, hasLength(1));
        expect(scheme.onTertiary, scheme.onPrimary);
        expect(
          entry.value().extension<PortfolioTokens>()!.focusRing,
          scheme.primary,
        );
        for (final color in terminalAccents) {
          expect(accents.contains(color), isFalse);
          expect(scheme.outline == color, isFalse);
        }
      });
    }
  });

  group('AppTheme terminal easter egg', () {
    late ThemeData theme;

    setUp(() {
      theme = AppTheme().getTerminalTheme();
    });

    test('keeps the dark mono terminal look scoped to the easter egg', () {
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, TerminalColors.bgBase);
      expect(theme.colorScheme.primary, TerminalColors.green);
      expect(theme.colorScheme.outline, TerminalColors.border);
      expect(theme.textTheme.bodyLarge?.fontFamily, BrandTheme.monoFamily);
    });
  });
}
