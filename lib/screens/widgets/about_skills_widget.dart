import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/data/models/skill.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

class AboutSkillsWidget extends StatelessWidget {
  const AboutSkillsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final repo = PortfolioRepository();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 60,
      ),
      child: isSmallScreen
          ? Column(
              children: [
                _aboutImage(colorScheme, repo),
                const SizedBox(height: 40),
                _aboutContent(t, colorScheme, repo),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 4, child: _aboutImage(colorScheme, repo)),
                const SizedBox(width: 60),
                Expanded(flex: 6, child: _aboutContent(t, colorScheme, repo)),
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
              color: colorScheme.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.person_outline,
                size: 120,
                color: colorScheme.primary.withAlpha(100),
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
  ) {
    final skills = repo.getSkills();
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
        AnimateOnVisible(
          builder: (context, visible) => Column(
            children: skills
                .asMap()
                .entries
                .map((entry) => _SkillBar(
                      skill: entry.value,
                      colorScheme: colorScheme,
                      colorIndex: entry.key,
                      animate: visible,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {},
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
                onPressed: () {},
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

class _SkillBar extends StatelessWidget {
  final Skill skill;
  final ColorScheme colorScheme;
  final int colorIndex;
  final bool animate;

  static const _palette = [
    Colors.blue,
    Colors.redAccent,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.pink,
    Colors.indigo,
    Colors.cyan,
  ];

  const _SkillBar({
    required this.skill,
    required this.colorScheme,
    required this.colorIndex,
    required this.animate,
  });

  Color get _color => _palette[colorIndex % _palette.length];

  @override
  Widget build(BuildContext context) {
    final barColor = _color;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: TextStyle(
                  color: barColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: animate
                ? TweenAnimationBuilder<double>(
                    key: ValueKey('skill_${skill.name}'),
                    tween: Tween<double>(begin: 0, end: skill.level),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      backgroundColor: colorScheme.onSurface.withAlpha(30),
                      valueColor: AlwaysStoppedAnimation<Color>(barColor),
                      minHeight: 6,
                    ),
                  )
                : LinearProgressIndicator(
                    value: 0,
                    backgroundColor: colorScheme.onSurface.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(barColor),
                    minHeight: 6,
                  ),
          ),
        ],
      ),
    );
  }
}
