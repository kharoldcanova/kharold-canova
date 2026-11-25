import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

/// "Disponibilidad inmediata" status pill (DESIGN.md 3.2). The dot uses the
/// semantic success token: it reports a status, it is not decoration.
class AvailabilityPill extends StatelessWidget {
  const AvailabilityPill({super.key, this.foreground, this.border});

  /// Overrides for coloured surfaces such as the contact block.
  final Color? foreground;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final dot = isDark ? BrandColors.darkSuccess : BrandColors.lightSuccess;
    final fg = foreground ?? theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BrandTheme.radiusFull),
        border: Border.all(color: border ?? theme.colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: dot.withValues(alpha: 0.25), spreadRadius: 3),
              ],
            ),
          ),
          const SizedBox(width: BrandTheme.spaceSM),
          Flexible(
            child: Text(
              t.availability_now,
              style: theme.textTheme.bodySmall?.copyWith(
                color: fg,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
