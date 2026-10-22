import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';

/// Roles that Flutter's [ColorScheme] does not model.
@immutable
class PortfolioTokens extends ThemeExtension<PortfolioTokens> {
  const PortfolioTokens({
    required this.onImage,
    required this.onImageMuted,
    required this.onImageBorder,
    required this.heroScrimTop,
    required this.heroScrimMid,
    required this.heroScrimBottom,
    required this.navSurface,
    required this.focusRing,
    required this.borderSubtle,
    required this.elevated,
    required this.contentMaxWidth,
  });

  final Color onImage;
  final Color onImageMuted;
  final Color onImageBorder;
  final Color heroScrimTop;
  final Color heroScrimMid;
  final Color heroScrimBottom;
  final Color navSurface;
  final Color focusRing;
  final Color borderSubtle;
  final Color elevated;
  final double contentMaxWidth;

  static const PortfolioTokens light = PortfolioTokens(
    onImage: BrandColors.onImage,
    onImageMuted: BrandColors.onImageMuted,
    onImageBorder: BrandColors.onImageBorder,
    heroScrimTop: BrandColors.heroScrimTop,
    heroScrimMid: BrandColors.heroScrimMid,
    heroScrimBottom: BrandColors.heroScrimBottom,
    navSurface: BrandColors.lightNavSurface,
    focusRing: BrandColors.lightFocusRing,
    borderSubtle: BrandColors.lightBorderSubtle,
    elevated: BrandColors.lightBgElevated,
    contentMaxWidth: BrandTheme.contentMaxWidth,
  );

  static const PortfolioTokens dark = PortfolioTokens(
    onImage: BrandColors.onImage,
    onImageMuted: BrandColors.onImageMuted,
    onImageBorder: BrandColors.onImageBorder,
    heroScrimTop: BrandColors.heroScrimTop,
    heroScrimMid: BrandColors.heroScrimMid,
    heroScrimBottom: BrandColors.heroScrimBottom,
    navSurface: BrandColors.darkNavSurface,
    focusRing: BrandColors.darkFocusRing,
    borderSubtle: BrandColors.darkBorderSubtle,
    elevated: BrandColors.darkBgElevated,
    contentMaxWidth: BrandTheme.contentMaxWidth,
  );

  @override
  PortfolioTokens copyWith({
    Color? onImage,
    Color? onImageMuted,
    Color? onImageBorder,
    Color? heroScrimTop,
    Color? heroScrimMid,
    Color? heroScrimBottom,
    Color? navSurface,
    Color? focusRing,
    Color? borderSubtle,
    Color? elevated,
    double? contentMaxWidth,
  }) {
    return PortfolioTokens(
      onImage: onImage ?? this.onImage,
      onImageMuted: onImageMuted ?? this.onImageMuted,
      onImageBorder: onImageBorder ?? this.onImageBorder,
      heroScrimTop: heroScrimTop ?? this.heroScrimTop,
      heroScrimMid: heroScrimMid ?? this.heroScrimMid,
      heroScrimBottom: heroScrimBottom ?? this.heroScrimBottom,
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
      onImage: Color.lerp(onImage, other.onImage, t)!,
      onImageMuted: Color.lerp(onImageMuted, other.onImageMuted, t)!,
      onImageBorder: Color.lerp(onImageBorder, other.onImageBorder, t)!,
      heroScrimTop: Color.lerp(heroScrimTop, other.heroScrimTop, t)!,
      heroScrimMid: Color.lerp(heroScrimMid, other.heroScrimMid, t)!,
      heroScrimBottom: Color.lerp(heroScrimBottom, other.heroScrimBottom, t)!,
      navSurface: Color.lerp(navSurface, other.navSurface, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      contentMaxWidth: lerpDouble(contentMaxWidth, other.contentMaxWidth, t) ??
          contentMaxWidth,
    );
  }
}
