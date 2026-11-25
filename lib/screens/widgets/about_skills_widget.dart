import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:kharoldcanova/screens/widgets/skill_groups_grid.dart';

/// "Sobre mí" (DESIGN.md 3.5): small photo, two first-person paragraphs and
/// a metrics strip with figures the CV states.
class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final paragraphStyle = theme.textTheme.bodyLarge?.copyWith(
      color: colorScheme.onSurface,
      height: 1.65,
    );
    final copy = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.about_p1, style: paragraphStyle),
          const SizedBox(height: BrandTheme.spaceMD),
          Text(t.about_p2, style: paragraphStyle),
        ],
      ),
    );

    return SectionContainer(
      topBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: t.about_title),
          const SizedBox(height: BrandTheme.spaceXL),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 640;
              final photo = _Photo(size: isWide ? 132 : 96);
              if (!isWide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    photo,
                    const SizedBox(height: 20),
                    copy,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  photo,
                  const SizedBox(width: BrandTheme.spaceXL),
                  Expanded(child: copy),
                ],
              );
            },
          ),
          const SizedBox(height: 28),
          const _Metrics(),
        ],
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      key: const Key('about-photo'),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/profile.jpg',
          semanticLabel: t.photo_alt,
          fit: BoxFit.cover,
          cacheWidth: 320,
        ),
      ),
    );
  }
}

/// Four figures in one bordered strip: 4 columns, 2 below 760px.
class _Metrics extends StatelessWidget {
  const _Metrics();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final line = colorScheme.outlineVariant;
    final facts = <({String key, String value, String label})>[
      (key: 'years', value: t.stat_years_value, label: t.stat_years_label),
      (key: 'users', value: t.stat_users_value, label: t.stat_users_label),
      (key: 'stores', value: t.stat_stores_value, label: t.stat_stores_label),
      (key: 'remote', value: t.stat_remote_value, label: t.stat_remote_label),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 760 ? 4 : 2;
        final cellWidth = (constraints.maxWidth - 2) / columns;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: line),
            borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
          ),
          child: Wrap(
            children: [
              for (var i = 0; i < facts.length; i++)
                Container(
                  key: Key('about-fact-${facts[i].key}'),
                  width: cellWidth,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: i % columns == 0
                          ? BorderSide.none
                          : BorderSide(color: line),
                      top: i < columns
                          ? BorderSide.none
                          : BorderSide(color: line),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        facts[i].value,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          height: 1.1,
                          letterSpacing: -0.6,
                          color: colorScheme.primary,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: BrandTheme.spaceXS),
                      Text(
                        facts[i].label,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// "Con qué trabajo": the CV's key-skill groups.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SectionContainer(
      topBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: t.skills_title),
          const SizedBox(height: BrandTheme.spaceLG),
          SkillGroupsGrid(groups: PortfolioRepository().getSkillGroups()),
        ],
      ),
    );
  }
}
