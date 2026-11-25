import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';

/// "Educación y certificaciones" (DESIGN.md 3.9): the CV's education entry,
/// then its four certification groups with the CV's wording.
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  static String _groupTitle(AppLocalizations t, String id) => switch (id) {
        'genai' => t.cert_group_genai,
        'ai' => t.cert_group_ai,
        'dev' => t.cert_group_dev,
        _ => t.cert_group_infra,
      };

  static IconData _groupIcon(String id) => switch (id) {
        'genai' => Icons.auto_awesome,
        'ai' => Icons.hub,
        'dev' => Icons.code,
        _ => Icons.lan,
      };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final groups = PortfolioRepository().getCertificationGroups();

    final education = _EntryRow(
      key: const Key('education-entry'),
      icon: Icons.school,
      eyebrow: '${t.education} · ${t.education_period}',
      lines: [t.education_school, t.education_degree],
      colorScheme: colorScheme,
    );

    return SectionContainer(
      topBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: t.education_title),
          const SizedBox(height: BrandTheme.space2XL),
          education,
          const SizedBox(height: BrandTheme.spaceXL),
          Text(
            t.certifications,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: BrandTheme.spaceMD),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 900 ? 2 : 1;
              const gap = BrandTheme.space2XL;
              final itemWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: 0,
                children: [
                  for (final group in groups)
                    SizedBox(
                      width: itemWidth,
                      child: _EntryRow(
                        key: Key('cert-group-${group.id}'),
                        icon: _groupIcon(group.id),
                        eyebrow: [
                          _groupTitle(t, group.id),
                          if (group.localizedMeta(languageCode) != null)
                            group.localizedMeta(languageCode)!,
                        ].join(' · '),
                        lines: group.localizedItems(languageCode),
                        colorScheme: colorScheme,
                      ),
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

/// One bordered row: icon tile, mono eyebrow and one line per item.
class _EntryRow extends StatelessWidget {
  const _EntryRow({
    super.key,
    required this.icon,
    required this.eyebrow,
    required this.lines,
    required this.colorScheme,
  });

  final IconData icon;
  final String eyebrow;
  final List<String> lines;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: BrandTheme.spaceMD + 4,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BrandTheme.radius),
              border: Border.all(
                color: colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: BrandTheme.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow.toUpperCase(),
                  style: BrandTextStyles.mono(
                    fontSize: 11,
                    weight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
                for (final line in lines) ...[
                  const SizedBox(height: BrandTheme.spaceXS),
                  Text(
                    line,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
