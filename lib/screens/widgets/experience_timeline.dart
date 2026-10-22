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

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.experience, style: theme.textTheme.headlineMedium),
        const SizedBox(height: BrandTheme.spaceSM),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            t.experience_desc,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: BrandTheme.spaceXL),
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

class _ExperienceEntry extends StatelessWidget {
  const _ExperienceEntry({required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final period = experience.periodLabel(t.present);

    final periodText = Text(
      period,
      style: BrandTextStyles.mono(
        fontSize: 12,
        weight: FontWeight.w500,
        color: colorScheme.primary,
        letterSpacing: 0.6,
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
