import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/radar_skills_chart.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSkillsWidget extends StatelessWidget {
  final VoidCallback? onHireMe;

  const AboutSkillsWidget({super.key, this.onHireMe});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;
    final repo = PortfolioRepository();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 260,
        vertical: 60,
      ),
      child: isSmallScreen
          ? Column(
              children: [
                _aboutImage(colorScheme, repo),
                const SizedBox(height: 40),
                _aboutContent(t, colorScheme, repo, onHireMe),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 4, child: _aboutImage(colorScheme, repo)),
                const SizedBox(width: 60),
                Expanded(flex: 6, child: _aboutContent(t, colorScheme, repo, onHireMe)),
              ],
            ),
    );
  }

  Widget _aboutImage(ColorScheme colorScheme, PortfolioRepository repo) {
    final years = repo.getTotalYearsExperience().toStringAsFixed(1);
    return Center(
      child: Stack(
        children: [
          Container(
            width: 320,
            height: 400,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                Icons.code,
                size: 120,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: -10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '+$years years',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutContent(
    AppLocalizations t,
    ColorScheme colorScheme,
    PortfolioRepository repo,
    VoidCallback? onHireMe,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.about_title,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          t.about_desc,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurface.withAlpha(179),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        const RadarSkillsChart(),
        const SizedBox(height: 24),
        Row(
          children: [
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onHireMe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                ),
                child: Text(t.hire_me),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 44,
              child: OutlinedButton(
                onPressed: () => launchUrl(Uri.parse(repo.getLinkedin())),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.onSurface,
                  side: BorderSide(color: colorScheme.onSurface.withAlpha(100)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                ),
                child: Text(t.about_me),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
