import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/experience_timeline.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';

/// "Experiencia" (DESIGN.md 3.5): its own destination, after "Sobre mí" and
/// before "Proyectos", as on the CV.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SectionContainer(
      topBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: t.experience),
          const SizedBox(height: BrandTheme.spaceXL),
          ExperienceTimeline(
            experiences: PortfolioRepository().getExperiences(),
          ),
        ],
      ),
    );
  }
}
