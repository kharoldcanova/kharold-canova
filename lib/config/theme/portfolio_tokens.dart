import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';

/// Roles that Flutter's [ColorScheme] does not model.
@immutable
class PortfolioTokens extends ThemeExtension<PortfolioTokens> {
  const PortfolioTokens({
    required this.navSurface,
    required this.focusRing,
    required this.borderSubtle,
    required this.elevated,
    required this.contentMaxWidth,
  });

  final Color navSurface;
  final Color focusRing;
  final Color borderSubtle;
  final Color elevated;
  final double contentMaxWidth;

  static const PortfolioTokens light = PortfolioTokens(
    navSurface: BrandColors.lightNavSurface,
    focusRing: BrandColors.lightFocusRing,
    borderSubtle: BrandColors.lightBorderSubtle,
    elevated: BrandColors.lightBgElevated,
    contentMaxWidth: BrandTheme.contentMaxWidth,
  );

  static const PortfolioTokens dark = PortfolioTokens(
    navSurface: BrandColors.darkNavSurface,
    focusRing: BrandColors.darkFocusRing,
    borderSubtle: BrandColors.darkBorderSubtle,
    elevated: BrandColors.darkBgElevated,
    contentMaxWidth: BrandTheme.contentMaxWidth,
  );

  @override
  PortfolioTokens copyWith({
    Color? navSurface,
    Color? focusRing,
    Color? borderSubtle,
    Color? elevated,
    double? contentMaxWidth,
  }) {
    return PortfolioTokens(
      navSurface: navSurface ?? this.navSurface,
      focusRing: focusRing ?? this.focusRing,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      elevated: elevated ?? this.elevated,
      contentMaxWidth: contentMaxWidth ?? this.contentMaxWidth,
    );
  }

  @override
  PortfolioTokens lerp(ThemeExtension<PortfolioTokens>? other, double t) {
    if (other is! PortfolioTokens) {
      return this;
    }
    return PortfolioTokens(
      navSurface: Color.lerp(navSurface, other.navSurface, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      contentMaxWidth: lerpDouble(contentMaxWidth, other.contentMaxWidth, t) ??
          contentMaxWidth,
    );
  }
}
