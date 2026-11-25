import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/models/published_skill.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({
    super.key,
    this.publishedSkill,
    this.projects,
  });

  final PublishedSkill? publishedSkill;
  final List<Project>? projects;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final repo = PortfolioRepository();
    final skill = publishedSkill ?? repo.getPublishedSkill();
    final items = projects ?? repo.getProjects();

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            index: '03',
            title: t.projects,
            description: t.projects_cv_note,
          ),
          if (skill != null) ...[
            const SizedBox(height: BrandTheme.space2XL),
            _PublishedSkillCard(skill: skill),
          ],
          const SizedBox(height: BrandTheme.space2XL),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1000
                  ? 3
                  : constraints.maxWidth >= 640
                      ? 2
                      : 1;
              const gap = BrandTheme.spaceLG;
              const cardHeight = 410.0;
              final cardWidth =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final project in items)
                    _ProjectCard(
                      project: project,
                      width: cardWidth,
                      height: cardHeight,
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

class _PublishedSkillCard extends StatelessWidget {
  const _PublishedSkillCard({required this.skill});

  final PublishedSkill skill;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(BrandTheme.spaceXL),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BrandTheme.spaceSM,
              vertical: BrandTheme.spaceXS,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(BrandTheme.radiusSM),
            ),
            child: Text(
              t.published_skill.toUpperCase(),
              style: BrandTextStyles.mono(
                fontSize: 11,
                weight: FontWeight.w500,
                color: colorScheme.onPrimary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: BrandTheme.spaceMD),
          Text(
            skill.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: BrandTheme.spaceSM),
          Text(
            skill.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          if (skill.installCommand != null) ...[
            const SizedBox(height: BrandTheme.spaceLG),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: BrandTheme.spaceMD,
                vertical: BrandTheme.spaceSM + 4,
              ),
              decoration: BoxDecoration(
                color: tokens.elevated,
                borderRadius: BorderRadius.circular(BrandTheme.radius),
                border: Border.all(color: colorScheme.outlineVariant, width: 1),
              ),
              child: Text(
                skill.installCommand!,
                style: BrandTextStyles.mono(
                  fontSize: 13,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ],
          const SizedBox(height: BrandTheme.spaceLG),
          OutlinedButton.icon(
            onPressed: () => launchUrl(
              Uri.parse(skill.url),
              mode: LaunchMode.externalApplication,
              webOnlyWindowName: '_blank',
            ),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: Text(t.view_skill),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.project,
    required this.width,
    required this.height,
  });

  final Project project;
  final double width;
  final double height;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  bool _focused = false;

  bool get _hasLink => widget.project.link?.isNotEmpty ?? false;

  void _open() {
    if (!_hasLink) return;
    launchUrl(
      Uri.parse(widget.project.link!),
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;
    final borderColor =
        _hovered || _focused ? colorScheme.primary : colorScheme.outline;

    return MouseRegion(
      cursor: _hasLink ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: CallbackShortcuts(
        bindings: _hasLink
            ? <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.enter): _open,
                const SingleActivator(LogicalKeyboardKey.space): _open,
              }
            : const <ShortcutActivator, VoidCallback>{},
        child: Focus(
          canRequestFocus: _hasLink,
          onFocusChange: (value) => setState(() => _focused = value),
          child: GestureDetector(
            onTap: _hasLink ? _open : null,
            child: Semantics(
              button: _hasLink,
              label: widget.project.title,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: widget.width,
                height: widget.height,
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
                          widget.project
                              .localizedCategory(languageCode)
                              .toUpperCase(),
                          style: BrandTextStyles.mono(
                            fontSize: 11,
                            color: colorScheme.onSurfaceVariant,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: BrandTheme.spaceLG),
                    Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: BrandTheme.spaceSM),
                    Text(
                      widget.project.localizedDescription(languageCode),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            height: 1.6,
                          ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: BrandTheme.spaceXS + 2,
                      runSpacing: BrandTheme.spaceXS + 2,
                      children: [
                        for (final tech
                            in widget.project.localizedTechStack(languageCode))
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: BrandTheme.spaceSM,
                              vertical: BrandTheme.spaceXS,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                BrandTheme.radiusSM,
                              ),
                              border: Border.all(
                                color: colorScheme.outlineVariant,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: BrandTextStyles.mono(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (_hasLink) ...[
                      const SizedBox(height: BrandTheme.spaceMD + 4),
                      Row(
                        children: [
                          Text(
                            widget.project.repoUrl != null
                                ? t.go_to_project
                                : t.view_site,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: colorScheme.primary),
                          ),
                          const SizedBox(width: BrandTheme.spaceXS),
                          Icon(
                            Icons.arrow_outward,
                            size: 14,
                            color: colorScheme.primary,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
