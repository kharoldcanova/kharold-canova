import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sección principal de "Sistemas de Inteligencia Artificial y Agentes".
/// Da protagonismo a ia-sql, Alma y LAIN.
class AISystemsWidget extends StatelessWidget {
  const AISystemsWidget({super.key, this.aiProjects});

  /// Lista opcional para pruebas o contenido alternativo.
  final List<Project>? aiProjects;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final projects = aiProjects ?? PortfolioRepository().getFeaturedAiProjects();

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            index: '01',
            title: t.ai_systems,
            description: t.ai_systems_desc,
          ),
          const SizedBox(height: BrandTheme.space2XL),
          if (projects.isEmpty)
            Text(
              t.ai_empty,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          else ...[
            Text(
              t.ai_featured.toUpperCase(),
              style: BrandTextStyles.mono(
                fontSize: 12,
                weight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: BrandTheme.spaceMD),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1000
                    ? 3
                    : constraints.maxWidth >= 680
                        ? 2
                        : 1;
                const gap = BrandTheme.spaceLG;
                final width =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var index = 0; index < projects.length; index++)
                      _AiProjectCard(
                        key: Key('ai-project-${projects[index].title}'),
                        project: projects[index],
                        rank: index + 1,
                        width: width,
                      ),
                  ],
                );
              },
            ),
          ],
          const SizedBox(height: BrandTheme.spaceXL),
          OutlinedButton.icon(
            key: const Key('ai-all-repos'),
            onPressed: () => launchUrl(
              Uri.parse(PortfolioRepository().getGithub()),
              mode: LaunchMode.externalApplication,
              webOnlyWindowName: '_blank',
            ),
            icon: const FaIcon(FontAwesomeIcons.github, size: 16),
            label: Text(t.ai_view_all_repos),
          ),
        ],
      ),
    );
  }
}

class _AiProjectCard extends StatefulWidget {
  const _AiProjectCard({
    super.key,
    required this.project,
    required this.rank,
    required this.width,
  });

  final Project project;
  final int rank;
  final double width;

  @override
  State<_AiProjectCard> createState() => _AiProjectCardState();
}

class _AiProjectCardState extends State<_AiProjectCard> {
  static const double _cardHeight = 400;
  static const int _maxVisibleTech = 3;

  bool _hovered = false;
  bool _focused = false;

  String? get _repoUrl {
    final url = widget.project.repoUrl;
    return url == null || url.isEmpty ? null : url;
  }

  void _openRepo() {
    if (_repoUrl == null) return;
    launchUrl(
      Uri.parse(_repoUrl!),
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final impact = widget.project.localizedImpact(languageCode);
    final tech = widget.project.localizedTechStack(languageCode);
    final visibleTech = tech.take(_maxVisibleTech).toList();
    final hiddenTech = tech.length - visibleTech.length;
    final borderColor =
        _hovered || _focused ? colorScheme.primary : colorScheme.outline;

    return MouseRegion(
      cursor: _repoUrl != null ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Focus(
        canRequestFocus: _repoUrl != null,
        onFocusChange: (value) => setState(() => _focused = value),
        child: GestureDetector(
          onTap: _repoUrl != null ? _openRepo : null,
          child: Semantics(
            button: _repoUrl != null,
            label: widget.project.title,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: widget.width,
              height: _cardHeight,
              padding: const EdgeInsets.all(BrandTheme.spaceLG),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(BrandTheme.radius),
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          widget.project.icon,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.rank.toString().padLeft(2, '0'),
                        style: BrandTextStyles.mono(
                          fontSize: 12,
                          weight: FontWeight.w500,
                          color: colorScheme.primary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: BrandTheme.spaceMD + 4),
                  Text(
                    widget.project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  if (impact != null) ...[
                    const SizedBox(height: BrandTheme.spaceSM),
                    Text(
                      impact,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: BrandTextStyles.mono(
                        fontSize: 12,
                        weight: FontWeight.w500,
                        color: colorScheme.primary,
                        height: 1.45,
                      ),
                    ),
                  ],
                  const SizedBox(height: BrandTheme.spaceSM + 4),
                  Text(
                    widget.project.localizedDescription(languageCode),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: BrandTheme.spaceXS + 2,
                    runSpacing: BrandTheme.spaceXS + 2,
                    children: [
                      for (final technology in visibleTech)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BrandTheme.spaceSM,
                            vertical: BrandTheme.spaceXS,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(BrandTheme.radiusSM),
                            border: Border.all(
                              color: colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            technology,
                            style: BrandTextStyles.mono(
                              fontSize: 11,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      if (hiddenTech > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: BrandTheme.spaceSM,
                            vertical: BrandTheme.spaceXS,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(BrandTheme.radiusSM),
                          ),
                          child: Text(
                            '+$hiddenTech',
                            style: BrandTextStyles.mono(
                              fontSize: 11,
                              weight: FontWeight.w500,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_repoUrl != null) ...[
                    const SizedBox(height: BrandTheme.spaceMD),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        key: Key('ai-project-link-${widget.project.title}'),
                        onPressed: _openRepo,
                        icon: const FaIcon(FontAwesomeIcons.github, size: 15),
                        label: Text(t.ai_view_repo),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
