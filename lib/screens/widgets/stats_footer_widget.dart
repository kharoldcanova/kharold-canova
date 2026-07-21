import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

class StatsFooterWidget extends StatelessWidget {
  const StatsFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;
    final repo = PortfolioRepository();

    final years = repo.getTotalYearsExperience();
    final repos = repo.getTotalRepos().toDouble();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            t.portfolio_title,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 48),
          AnimateOnVisible(
            builder: (context, visible) {
              if (isSmallScreen) {
                return Column(
                  children: [
                    _StatCard(
                      label: t.stats_exp(''),
                      value: years,
                      colorScheme: cs,
                      animate: visible,
                    ),
                    const SizedBox(height: 24),
                    _StatCard(
                      label: t.stats_repos(''),
                      value: repos,
                      colorScheme: cs,
                      animate: visible,
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatCard(
                    label: t.stats_exp(''),
                    value: years,
                    colorScheme: cs,
                    animate: visible,
                  ),
                  const SizedBox(width: 32),
                  _StatCard(
                    label: t.stats_repos(''),
                    value: repos,
                    colorScheme: cs,
                    animate: visible,
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
    final cs = widget.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        width: 400,
        height: 400,
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -6.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cs.primary,
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? .18 : .10),
              blurRadius: _hovered ? 28 : 14,
              offset: Offset(0, _hovered ? 14 : 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.animate)
                TweenAnimationBuilder<double>(
                  key: ValueKey(widget.value),
                  tween: Tween(
                    begin: 0,
                    end: widget.value,
                  ),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    final hasDecimals =
                        widget.value != widget.value.roundToDouble();

                    return Text(
                      hasDecimals
                          ? '+${value.toStringAsFixed(1)}'
                          : '+${value.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 62,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    );
                  },
                )
              else
                const Text(
                  "+0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 18),
              Text(
                widget.label.replaceAll(RegExp(r'\+.*? '), ''),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .85),
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
