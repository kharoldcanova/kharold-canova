import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/profile/widgets/skill_chip.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfoSection extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<Offset> slide;

  const ProfileInfoSection({
    super.key,
    required this.opacity,
    required this.slide,
  });

  static const _techs = [
    'Flutter',
    'Laravel',
    'Docker',
    'GitHub Actions',
    'PostgreSQL',
    'Firebase',
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 1),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const Text(
                        'KHAROLD',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.profile_title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withValues(alpha: 0.8),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _techs.map((tech) {
                          return SkillChip(label: tech);
                        }).toList(),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _StatItem(
                            value: '2021',
                            label: t.profile_since,
                          ),
                          const SizedBox(width: 48),
                          _StatItem(
                            value: '+30',
                            label: t.projects,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.profile_expertise,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.7),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            const pdfPath = 'assets/cv-flutter.pdf';
                            if (!await launchUrl(Uri.parse(pdfPath))) {
                              throw Exception('No se pudo abrir el PDF');
                            }
                          },
                          icon: const Icon(Icons.download, size: 18),
                          label: Text(t.download_cv),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.6),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
