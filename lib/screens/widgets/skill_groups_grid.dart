import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/models/skill_group.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

/// "Con qué trabajo" (DESIGN.md 3.5): the CV's key-skill groups as a quiet
/// two-column list; one column below 760px.
class SkillGroupsGrid extends StatelessWidget {
  const SkillGroupsGrid({super.key, required this.groups});

  final List<SkillGroup> groups;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        const gap = BrandTheme.space2XL;
        final itemWidth =
            isWide ? (constraints.maxWidth - gap) / 2 : constraints.maxWidth;
        return Wrap(
          spacing: gap,
          children: [
            for (final group in groups)
              SizedBox(
                key: Key('skill-group-${group.id}'),
                width: itemWidth,
                child: _SkillGroupItem(group: group),
              ),
          ],
        );
      },
    );
  }
}

class _SkillGroupItem extends StatelessWidget {
  const _SkillGroupItem({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _titleFor(t, group.id),
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            group.localizedTechnologies(languageCode).join(', '),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.55,
            ),
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
}
