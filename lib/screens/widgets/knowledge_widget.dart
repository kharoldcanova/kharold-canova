import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';

class KnowledgeWidget extends StatelessWidget {
  const KnowledgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final items = <({IconData icon, String label})>[
      (icon: Icons.android, label: t.service_android),
      (icon: Icons.apple, label: t.service_ios),
      (icon: Icons.html, label: t.service_web),
      (icon: Icons.rocket_launch_outlined, label: t.service_rag),
      (icon: Icons.psychology_outlined, label: t.service_scripts),
      (icon: Icons.terminal, label: t.service_contact),
    ];

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            index: '03',
            title: t.knowledge,
            description: t.knowledge_desc,
          ),
          const SizedBox(height: BrandTheme.space2XL),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1000
                  ? 3
                  : constraints.maxWidth >= 640
                      ? 2
                      : 1;
              const spacing = BrandTheme.spaceMD;
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (var i = 0; i < items.length; i++)
                    _KnowledgeCard(
                      index: i + 1,
                      icon: items[i].icon,
                      label: items[i].label,
                      width: cardWidth,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _KnowledgeCard extends StatefulWidget {
  const _KnowledgeCard({
    required this.index,
    required this.icon,
    required this.label,
    required this.width,
  });

  final int index;
  final IconData icon;
  final String label;
  final double width;

  @override
  State<_KnowledgeCard> createState() => _KnowledgeCardState();
}

class _KnowledgeCardState extends State<_KnowledgeCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: widget.width,
        constraints: const BoxConstraints(minHeight: 148),
        padding: const EdgeInsets.all(BrandTheme.spaceLG),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
          border: Border.all(
            color: _hovered ? colorScheme.primary : colorScheme.outline,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, size: 26, color: colorScheme.primary),
                const Spacer(),
                Text(
                  widget.index.toString().padLeft(2, '0'),
                  style: BrandTextStyles.mono(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: BrandTheme.spaceLG),
            Text(
              widget.label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
