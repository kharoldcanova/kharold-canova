import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/models/experience.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class ExperienceTimeline extends StatelessWidget {
  const ExperienceTimeline({super.key, required this.experiences});

  final List<Experience> experiences;

  @override
  Widget build(BuildContext context) {
    if (experiences.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < experiences.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: BrandTheme.spaceXL),
            Divider(
              height: 1,
              color: theme.colorScheme.outlineVariant,
            ),
            const SizedBox(height: BrandTheme.spaceXL),
          ],
          _ExperienceEntry(experience: experiences[i]),
        ],
      ],
    );
  }
}

/// CV date format: `09/2023`.
const _monthsEs = [
  'ene', 'feb', 'mar', 'abr', 'may', 'jun', //
  'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
];
const _monthsEn = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// "sep 2023" / "Sep 2023": how a person writes a date on a portfolio.
String cvMonth(DateTime date, [String languageCode = 'es']) =>
    '${(languageCode == 'en' ? _monthsEn : _monthsEs)[date.month - 1]} ${date.year}';

class _ExperienceEntry extends StatelessWidget {
  const _ExperienceEntry({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final end = experience.endDate == null
        ? t.present
        : cvMonth(experience.endDate!, languageCode);
    final period = '${cvMonth(experience.startDate, languageCode)} – $end';

    final periodText = Text(
      period,
      style: theme.textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );

    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(experience.localizedRole(languageCode),
            style: theme.textTheme.titleLarge),
        const SizedBox(height: BrandTheme.spaceXS),
        Text(
          experience.company,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (experience.localizedLocation(languageCode).isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            experience.localizedLocation(languageCode),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (experience.localizedHighlights(languageCode).isNotEmpty) ...[
          const SizedBox(height: BrandTheme.spaceMD),
          for (final highlight in experience.localizedHighlights(languageCode))
            Padding(
              padding: const EdgeInsets.only(bottom: BrandTheme.spaceSM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                      right: BrandTheme.spaceSM + 2,
                    ),
                    child: Container(
                      width: BrandTheme.spaceXS,
                      height: BrandTheme.spaceXS,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      highlight,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              periodText,
              const SizedBox(height: BrandTheme.spaceSM),
              details,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 140, child: periodText),
            const SizedBox(width: BrandTheme.spaceLG),
            Expanded(child: details),
          ],
        );
      },
    );
  }
}
