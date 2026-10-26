import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';

class CertificationItem {
  const CertificationItem({
    required this.title,
    required this.subtitle,
    this.subtitleEn,
    required this.date,
    this.dateEn,
    this.icon = Icons.workspace_premium_outlined,
  });

  final String title;
  final String subtitle;
  final String? subtitleEn;
  final String date;
  final String? dateEn;
  final IconData icon;

  String localizedSubtitle(String languageCode) =>
      languageCode == 'en' ? (subtitleEn ?? subtitle) : subtitle;

  String localizedDate(String languageCode) =>
      languageCode == 'en' ? (dateEn ?? date) : date;
}

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final certifications = PortfolioRepository().getCertifications();

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            index: '05',
            title: t.certifications_title,
            description: t.certifications_subtitle,
          ),
          const SizedBox(height: BrandTheme.space2XL),
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
                  for (final certification in certifications)
                    SizedBox(
                      width: itemWidth,
                      child: _CertificationRow(
                        item: certification,
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

class _CertificationRow extends StatelessWidget {
  const _CertificationRow({
    required this.item,
    required this.colorScheme,
  });

  final CertificationItem item;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
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
              item.icon,
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
                  item.title.toUpperCase(),
                  style: BrandTextStyles.mono(
                    fontSize: 11,
                    weight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: BrandTheme.spaceXS),
                Text(
                  item.localizedSubtitle(languageCode),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: BrandTheme.spaceXS),
                Text(
                  item.localizedDate(languageCode),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
