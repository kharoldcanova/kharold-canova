import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.background,
    this.topBorder = false,
  });

  final Widget child;
  final Color? background;
  final bool topBorder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 900;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: background ?? Colors.transparent,
        border: topBorder
            ? Border(
                top: BorderSide(color: colorScheme.outlineVariant, width: 1),
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              isCompact ? BrandTheme.gutterMobile : BrandTheme.gutterDesktop,
          vertical: isCompact ? 72 : BrandTheme.sectionVertical,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: BrandTheme.contentMaxWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    this.index,
    required this.title,
    this.description,
  });

  /// Optional mono eyebrow ("01 — TITLE"); only the terminal easter egg uses it.
  final String? index;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != null) ...[
          Text(
            '$index — ${title.toUpperCase()}',
            style: BrandTextStyles.mono(
              fontSize: 12,
              weight: FontWeight.w500,
              color: colorScheme.primary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: BrandTheme.spaceSM + 4),
        ],
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        if (description != null) ...[
          const SizedBox(height: BrandTheme.spaceSM + 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              description!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
