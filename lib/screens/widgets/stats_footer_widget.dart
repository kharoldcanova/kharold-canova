import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

class StatsFooterWidget extends StatelessWidget {
  const StatsFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final repo = PortfolioRepository();

    final years = repo.getTotalYearsExperience();
    final repos = repo.getTotalRepos().toDouble();

    return Container(
      color: colorScheme.primary,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            t.portfolio_title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          AnimateOnVisible(
            builder: (context, visible) => isSmallScreen
                ? Column(
                    children: [
                      _StatCard(
                        label: t.stats_exp(''),
                        value: years,
                        colorScheme: colorScheme,
                        animate: visible,
                      ),
                      const SizedBox(height: 20),
                      _StatCard(
                        label: t.stats_repos(''),
                        value: repos,
                        colorScheme: colorScheme,
                        animate: visible,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: t.stats_exp(''),
                          value: years,
                          colorScheme: colorScheme,
                          animate: visible,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _StatCard(
                          label: t.stats_repos(''),
                          value: repos,
                          colorScheme: colorScheme,
                          animate: visible,
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

class _StatCard extends StatefulWidget {
  final String label;
  final double value;
  final ColorScheme colorScheme;
  final bool animate;

  const _StatCard({
    required this.label,
    required this.value,
    required this.colorScheme,
    required this.animate,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          color: _hovered
              ? Colors.white.withAlpha(25)
              : Colors.white.withAlpha(15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.animate)
              TweenAnimationBuilder<double>(
                key: ValueKey('counter_${widget.value}'),
                tween: Tween<double>(begin: 0, end: widget.value),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOutCubic,
                builder: (context, val, _) {
                  final isDecimal = val != val.roundToDouble();
                  return Text(
                    isDecimal
                        ? '+${val.toStringAsFixed(1)}'
                        : '+${val.toInt()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              )
            else
              const Text(
                '+0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.label.replaceAll(RegExp(r'\+.*? '), ''),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
