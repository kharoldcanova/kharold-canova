import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/models/skill_group.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class SkillGroupsGrid extends StatelessWidget {
  const SkillGroupsGrid({super.key, required this.groups});

  final List<SkillGroup> groups;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.core_competencies, style: theme.textTheme.headlineMedium),
        const SizedBox(height: BrandTheme.spaceXL),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;
            final cardWidth = isWide
                ? (constraints.maxWidth - BrandTheme.spaceMD) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: BrandTheme.spaceMD,
              runSpacing: BrandTheme.spaceMD,
              children: [
                for (final group in groups)
                  SizedBox(
                    key: Key('skill-group-${group.id}'),
                    width: cardWidth,
                    child: _SkillGroupCard(group: group),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      padding: const EdgeInsets.all(BrandTheme.spaceLG),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
        border: Border.all(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _iconFor(group.id),
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: BrandTheme.spaceSM),
              Expanded(
                child: Text(
                  _titleFor(t, group.id),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BrandTheme.spaceMD),
          Wrap(
            spacing: BrandTheme.spaceSM,
            runSpacing: BrandTheme.spaceSM,
            children: [
              for (final technology
                  in group.localizedTechnologies(languageCode))
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(BrandTheme.radius),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    technology,
                    style: BrandTextStyles.mono(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  static String _titleFor(AppLocalizations t, String id) {
    switch (id) {
      case 'mobile':
        return t.skill_group_mobile;
      case 'ai':
        return t.skill_group_ai;
      case 'devops':
        return t.skill_group_devops;
      case 'frontend':
        return t.skill_group_frontend;
      default:
        return t.skill_group_backend;
    }
  }

  static IconData _iconFor(String id) {
    switch (id) {
      case 'mobile':
        return Icons.phone_iphone_outlined;
      case 'ai':
        return Icons.auto_awesome_outlined;
      case 'devops':
        return Icons.terminal_outlined;
      case 'frontend':
        return Icons.web_outlined;
      default:
        return Icons.storage_outlined;
    }
  }
}
