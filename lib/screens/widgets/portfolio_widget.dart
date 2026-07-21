import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1200;
    final horizontalPadding = isDesktop ? 80.0 : 24.0;
    final projects = PortfolioRepository().getProjects();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            t.portfolio_title,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            t.portfolio_desc,
            style: TextStyle(
              fontSize: 16,
              color: cs.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: projects.map((project) {
              return _ProjectCard(project: project, isDesktop: isDesktop);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isDesktop;

  const _ProjectCard({
    required this.project,
    required this.isDesktop,
    super.key,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    final double paddingHorizontal = widget.isDesktop ? 160.0 : 48.0;
    final double cardWidth = widget.isDesktop
        ? ((width - paddingHorizontal - 48) / 3).clamp(300.0, 500.0)
        : (width - paddingHorizontal);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setExpanded(true),
      onExit: (_) => _setExpanded(false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _setExpanded(!_isExpanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          width: cardWidth,
          transform: _isExpanded
              ? (Matrix4.identity()..translate(0.0, -6.0))
              : Matrix4.identity(),
          // Usamos ClipRRect para que el contenido respete las esquinas redondeadas
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: _isExpanded ? cs.surfaceContainerHighest : cs.surface,
                borderRadius: BorderRadius.circular(12),
                // Borde uniforme -> Adiós al error
                border: Border.all(
                  color: _isExpanded
                      ? cs.primary
                      : cs.outlineVariant.withAlpha(128),
                  width: _isExpanded ? 1.5 : 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isExpanded ? 0.12 : 0.04),
                    blurRadius: _isExpanded ? 24 : 8,
                    offset: Offset(0, _isExpanded ? 12 : 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Línea de acento superior que aparece al expandirse
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isExpanded ? 4 : 0,
                    width: double.infinity,
                    color: cs.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        AnimatedCrossFade(
                          firstChild:
                              const SizedBox(width: double.infinity, height: 0),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.project.description,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.project.techStack.join(' · '),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: cs.onSurface.withAlpha(140),
                                  ),
                                ),
                                if (widget.project.repoUrl != null) ...[
                                  const SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4),
                                      onTap: () async {
                                        final uri =
                                            Uri.parse(widget.project.repoUrl!);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(uri);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          'GitHub →',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: cs.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          crossFadeState: _isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                          sizeCurve: Curves.easeOutCubic,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setExpanded(bool value) {
    if (mounted && value != _isExpanded) {
      setState(() => _isExpanded = value);
    }
  }
}
