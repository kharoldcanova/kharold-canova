import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:kharoldcanova/screens/widgets/skill_groups_grid.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSkillsWidget extends StatelessWidget {
  const AboutSkillsWidget({super.key, this.onHireMe});

  final VoidCallback? onHireMe;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final repo = PortfolioRepository();

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            index: '01',
            title: t.about_title,
            description: t.profile_quote,
          ),
          const SizedBox(height: BrandTheme.space2XL),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final bio = _AboutCopy(onHireMe: onHireMe, repo: repo);
              final stats = _StatsPanel(repo: repo);

              if (!isWide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    bio,
                    const SizedBox(height: BrandTheme.spaceXL),
                    stats,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: bio),
                  const SizedBox(width: BrandTheme.space2XL),
                  Expanded(flex: 4, child: stats),
                ],
              );
            },
          ),
          const SizedBox(height: BrandTheme.space2XL + BrandTheme.spaceMD),
          SkillGroupsGrid(groups: repo.getSkillGroups()),
        ],
      ),
    );
  }
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy({required this.onHireMe, required this.repo});

  final VoidCallback? onHireMe;
  final PortfolioRepository repo;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.about_desc,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.65,
              ),
        ),
        const SizedBox(height: BrandTheme.spaceXL),
        Wrap(
          spacing: BrandTheme.spaceSM + 4,
          runSpacing: BrandTheme.spaceSM + 4,
          children: [
            ElevatedButton(
              onPressed: onHireMe,
              child: Text(t.contact_me),
            ),
            OutlinedButton(
              onPressed: () => launchUrl(
                Uri.parse(repo.getLinkedin()),
                mode: LaunchMode.externalApplication,
                webOnlyWindowName: '_blank',
              ),
              child: Text(t.about_me),
            ),
          ],
        ),
      ],
    );
  }
}

/// CV facts (DESIGN.md 3.5): only figures the CV states.
class _StatsPanel extends StatelessWidget {
  const _StatsPanel({required this.repo});

  final PortfolioRepository repo;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final facts = <({String key, String value, String label})>[
      (key: 'years', value: t.stat_years_value, label: t.stat_years_label),
      (key: 'users', value: t.stat_users_value, label: t.stat_users_label),
      (key: 'remote', value: t.stat_remote_value, label: t.stat_remote_label),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BrandTheme.spaceLG),
      decoration: BoxDecoration(
        color: tokens.elevated,
        borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
        border: Border.all(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.impact.toUpperCase(),
            style: BrandTextStyles.mono(
              fontSize: 11,
              weight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: BrandTheme.spaceMD),
          for (var i = 0; i < facts.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: BrandTheme.spaceMD),
              Divider(height: 1, color: colorScheme.outlineVariant),
              const SizedBox(height: BrandTheme.spaceMD),
            ],
            _StatRow(
              key: Key('about-fact-${facts[i].key}'),
              value: facts[i].value,
              label: facts[i].label,
            ),
          ],
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ),
        const SizedBox(width: BrandTheme.spaceMD),
        Text(
          value,
          style: BrandTextStyles.mono(
            fontSize: 28,
            weight: FontWeight.w500,
            color: colorScheme.primary,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }
}
