import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/ai_systems_widget.dart';
import 'package:kharoldcanova/screens/widgets/certifications_section.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/experience_timeline.dart';
import 'package:kharoldcanova/screens/widgets/knowledge_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:kharoldcanova/screens/widgets/skill_groups_grid.dart';
import 'package:url_launcher/url_launcher.dart';

enum _TerminalTab { ai, about, skills, projects, certifications, contact }

/// Optional terminal easter egg, opened from the footer `>_` button.
///
/// It always renders with [AppTheme.getTerminalTheme], whatever the app mode,
/// and closes back to the portfolio with its exit button, the red window dot
/// or Escape.
class TerminalLandingPage extends StatefulWidget {
  const TerminalLandingPage({super.key});

  @override
  State<TerminalLandingPage> createState() => _TerminalLandingPageState();
}

class _TerminalLandingPageState extends State<TerminalLandingPage> {
  final _repository = PortfolioRepository();
  _TerminalTab? _selectedTab;
  bool _showHelp = false;

  String get _command {
    if (_selectedTab == null) return _showHelp ? 'help' : 'whoami';
    return switch (_selectedTab!) {
      _TerminalTab.ai => 'agents --list',
      _TerminalTab.about => 'about',
      _TerminalTab.skills => 'stack',
      _TerminalTab.projects => 'git log --oneline',
      _TerminalTab.certifications => 'certifications --list',
      _TerminalTab.contact => 'contact --links',
    };
  }

  void _selectTab(_TerminalTab tab) {
    setState(() {
      _selectedTab = tab;
      _showHelp = false;
    });
  }

  void _close() => Navigator.of(context).maybePop();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme().getTerminalTheme(),
      child: CallbackShortcuts(
        bindings: <ShortcutActivator, VoidCallback>{
          const SingleActivator(LogicalKeyboardKey.escape): _close,
        },
        child: Focus(
          autofocus: true,
          child: Builder(builder: _buildWindow),
        ),
      ),
    );
  }

  Widget _buildWindow(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final maxWidth = (size.width - 32).clamp(280.0, 1280.0).toDouble();

    return Scaffold(
      backgroundColor: TerminalColors.bgBase,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: SizedBox(
              key: const Key('terminal-window'),
              width: maxWidth,
              height: constraints.maxHeight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: BrandTheme.spaceMD),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: TerminalColors.bgSurface,
                      border:
                          Border.all(color: TerminalColors.border, width: 1),
                      borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            _WindowBar(
                              onClose: _close,
                              onToggleLanguage: _toggleLanguage,
                              onOpenCv: () => _openExternal(
                                Uri.base.resolve(_repository.getCvUrl(
                                    Localizations.localeOf(context)
                                        .languageCode)),
                              ),
                              onOpenMedium: () {
                                final medium = _repository.getMedium();
                                if (medium != null) {
                                  _openExternal(Uri.parse(medium));
                                }
                              },
                            ),
                            _TerminalPrompt(
                              command: _command,
                              disableAnimations: disableAnimations,
                            ),
                            _TerminalNavigation(
                              selectedTab: _selectedTab,
                              onSelected: _selectTab,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                key: const Key('terminal-output-scroll'),
                                child: AnimatedSwitcher(
                                  duration: disableAnimations
                                      ? Duration.zero
                                      : const Duration(milliseconds: 220),
                                  child: KeyedSubtree(
                                    key: ValueKey<Object?>(
                                      _selectedTab ?? 'whoami-$_showHelp',
                                    ),
                                    child: _buildOutput(context),
                                  ),
                                ),
                              ),
                            ),
                            _StatusBar(
                              text: AppLocalizations.of(context)!
                                  .profile_expertise,
                            ),
                          ],
                        ),
                        const Positioned.fill(
                          child: IgnorePointer(
                            child: CustomPaint(
                              foregroundPainter: _ScanlinePainter(
                                TerminalColors.scanline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleLanguage() {
    final bloc = context.read<LanguageBloc>();
    final next = bloc.state.selectedLanguage == Language.spanish
        ? Language.english
        : Language.spanish;
    bloc.add(ChangeLanguage(selectedLanguage: next));
  }

  Widget _buildOutput(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final tab = _selectedTab;

    if (tab == null) {
      return _WelcomeOutput(
        role: t.hero_subtitle,
        profile: t.profile_quote,
        showHelp: _showHelp,
        onRunHelp: () => setState(() => _showHelp = !_showHelp),
        onOpenContact: () => _selectTab(_TerminalTab.contact),
        onDownloadCv: () => _openExternal(
          Uri.base.resolve(_repository
              .getCvUrl(Localizations.localeOf(context).languageCode)),
        ),
      );
    }

    return switch (tab) {
      _TerminalTab.ai => const AISystemsWidget(),
      _TerminalTab.about => SectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                index: '01',
                title: t.about_title,
                description: t.profile_quote,
              ),
              const SizedBox(height: BrandTheme.space2XL),
              Text(
                t.about_desc,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.65,
                    ),
              ),
              const SizedBox(height: BrandTheme.space2XL),
              ExperienceTimeline(experiences: _repository.getExperiences()),
            ],
          ),
        ),
      _TerminalTab.skills => SectionContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                index: '02',
                title: t.knowledge,
                description: t.knowledge_desc,
              ),
              const SizedBox(height: BrandTheme.space2XL),
              SkillGroupsGrid(groups: _repository.getSkillGroups()),
              const SizedBox(height: BrandTheme.space2XL),
              const KnowledgeWidget(),
            ],
          ),
        ),
      _TerminalTab.projects => const PortfolioWidget(),
      _TerminalTab.certifications => const CertificationsSection(),
      _TerminalTab.contact => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ContactWidget(),
            _SocialLinks(repository: _repository),
          ],
        ),
    };
  }

  Future<void> _openExternal(Uri uri) => launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
}

class _WindowBar extends StatelessWidget {
  const _WindowBar({
    required this.onClose,
    required this.onToggleLanguage,
    required this.onOpenCv,
    required this.onOpenMedium,
  });

  final VoidCallback onClose;
  final VoidCallback onToggleLanguage;
  final VoidCallback onOpenCv;
  final VoidCallback onOpenMedium;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 620;
    final title = Text(
      'kharold@portfolio:~',
      key: const Key('terminal-window-title'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: BrandTextStyles.mono(
        fontSize: 13,
        color: TerminalColors.textSecondary,
      ),
    );
    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _WindowControl(
          key: const Key('terminal-window-close'),
          color: TerminalColors.red,
          label: AppLocalizations.of(context)!.terminal_close,
          onTap: onClose,
        ),
        const SizedBox(width: BrandTheme.spaceSM),
        const _WindowControl(
          key: Key('terminal-window-minimize'),
          color: TerminalColors.amber,
          label: 'Minimize window',
        ),
        const SizedBox(width: BrandTheme.spaceSM),
        const _WindowControl(
          key: Key('terminal-window-maximize'),
          color: TerminalColors.green,
          label: 'Maximize window',
        ),
      ],
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: TerminalColors.bgElevated,
        border: Border(
          bottom: BorderSide(color: TerminalColors.border, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: BrandTheme.spaceMD,
          vertical: BrandTheme.spaceSM,
        ),
        child: Column(
          children: [
            Row(
              children: [
                controls,
                if (!isCompact) ...[
                  const SizedBox(width: BrandTheme.spaceXL),
                  Expanded(child: Center(child: title)),
                  const SizedBox(width: BrandTheme.spaceXL),
                  _WindowActions(
                    onClose: onClose,
                    onToggleLanguage: onToggleLanguage,
                    onOpenCv: onOpenCv,
                    onOpenMedium: onOpenMedium,
                  ),
                ] else ...[
                  const SizedBox(width: BrandTheme.spaceMD),
                  Expanded(child: title),
                ],
              ],
            ),
            if (isCompact) ...[
              const SizedBox(height: BrandTheme.spaceSM),
              Align(
                alignment: Alignment.centerRight,
                child: _WindowActions(
                  onClose: onClose,
                  onToggleLanguage: onToggleLanguage,
                  onOpenCv: onOpenCv,
                  onOpenMedium: onOpenMedium,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WindowActions extends StatelessWidget {
  const _WindowActions({
    required this.onClose,
    required this.onToggleLanguage,
    required this.onOpenCv,
    required this.onOpenMedium,
  });

  final VoidCallback onClose;
  final VoidCallback onToggleLanguage;
  final VoidCallback onOpenCv;
  final VoidCallback onOpenMedium;

  @override
  Widget build(BuildContext context) {
    final language = context.select<LanguageBloc, Language>(
      (bloc) => bloc.state.selectedLanguage,
    );
    final t = AppLocalizations.of(context)!;
    final repo = PortfolioRepository();
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          key: const Key('terminal-github'),
          tooltip: 'GitHub',
          onPressed: () => launchUrl(
            Uri.parse(repo.getGithub()),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
          icon: const FaIcon(
            FontAwesomeIcons.github,
            color: TerminalColors.textSecondary,
            size: 18,
          ),
          visualDensity: VisualDensity.compact,
        ),
        IconButton(
          key: const Key('terminal-linkedin'),
          tooltip: 'LinkedIn',
          onPressed: () => launchUrl(
            Uri.parse(repo.getLinkedin()),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
          icon: const FaIcon(
            FontAwesomeIcons.linkedin,
            color: TerminalColors.textSecondary,
            size: 18,
          ),
          visualDensity: VisualDensity.compact,
        ),
        TextButton(
          key: const Key('terminal-language-toggle'),
          onPressed: onToggleLanguage,
          style: TextButton.styleFrom(
            foregroundColor: TerminalColors.cyan,
            textStyle: BrandTextStyles.mono(fontSize: 12),
            minimumSize: const Size(40, 36),
          ),
          child: Text(language == Language.spanish ? 'EN' : 'ES'),
        ),
        IconButton(
          key: const Key('cv-download'),
          tooltip: t.download_cv,
          onPressed: onOpenCv,
          icon: const Icon(
            Icons.download_outlined,
            color: TerminalColors.textSecondary,
            size: 18,
          ),
          visualDensity: VisualDensity.compact,
        ),
        IconButton(
          key: const Key('medium-link'),
          tooltip: 'Medium',
          onPressed: onOpenMedium,
          icon: const Icon(
            Icons.article_outlined,
            color: TerminalColors.textSecondary,
            size: 18,
          ),
          visualDensity: VisualDensity.compact,
        ),
        IconButton(
          key: const Key('terminal-exit'),
          tooltip: t.terminal_close,
          onPressed: onClose,
          icon: const Icon(
            Icons.close,
            color: TerminalColors.textSecondary,
            size: 18,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

class _WindowControl extends StatelessWidget {
  const _WindowControl({
    super.key,
    required this.color,
    required this.label,
    this.onTap,
  });

  final Color color;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    return Semantics(
      label: label,
      button: onTap != null,
      child: onTap == null
          ? dot
          : MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(onTap: onTap, child: dot),
            ),
    );
  }
}

class _TerminalPrompt extends StatelessWidget {
  const _TerminalPrompt({
    required this.command,
    required this.disableAnimations,
  });

  final String command;
  final bool disableAnimations;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          BrandTheme.spaceLG,
          BrandTheme.spaceMD,
          BrandTheme.spaceLG,
          BrandTheme.spaceSM,
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'kharold@portfolio',
              style: BrandTextStyles.mono(
                fontSize: 13,
                weight: FontWeight.w500,
                color: TerminalColors.green,
              ),
            ),
            Text(
              ':~',
              style: BrandTextStyles.mono(
                fontSize: 13,
                color: TerminalColors.textSecondary,
              ),
            ),
            Text(
              '\$ ',
              style: BrandTextStyles.mono(
                fontSize: 13,
                color: TerminalColors.magenta,
              ),
            ),
            Text(
              command,
              key: const Key('terminal-command'),
              style: BrandTextStyles.mono(
                fontSize: 13,
                weight: FontWeight.w500,
                color: TerminalColors.cyan,
              ),
            ),
            const SizedBox(width: BrandTheme.spaceXS),
            _BlinkingCursor(disableAnimations: disableAnimations),
          ],
        ),
      );
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({required this.disableAnimations});

  final bool disableAnimations;

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor> {
  Timer? _blinkTimer;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startBlinking();
  }

  @override
  void didUpdateWidget(covariant _BlinkingCursor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.disableAnimations == widget.disableAnimations) return;
    _blinkTimer?.cancel();
    _visible = true;
    _startBlinking();
  }

  void _startBlinking() {
    if (widget.disableAnimations) return;
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 720), (_) {
      if (mounted) setState(() => _visible = !_visible);
    });
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        key: const Key('terminal-cursor'),
        opacity: AlwaysStoppedAnimation<double>(_visible ? 1 : 0.18),
        child: Text(
          '_',
          style: BrandTextStyles.mono(
            fontSize: 15,
            weight: FontWeight.w500,
            color: TerminalColors.yellow,
          ),
        ),
      );
}

class _TerminalNavigation extends StatelessWidget {
  const _TerminalNavigation({
    required this.selectedTab,
    required this.onSelected,
  });

  final _TerminalTab? selectedTab;
  final ValueChanged<_TerminalTab> onSelected;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: TerminalColors.border, width: 1),
            bottom: BorderSide(color: TerminalColors.border, width: 1),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final buttons = [
              for (final tab in _TerminalTab.values)
                _TerminalTabButton(
                  tab: tab,
                  selected: tab == selectedTab,
                  onPressed: () => onSelected(tab),
                ),
            ];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: BrandTheme.spaceSM,
                vertical: BrandTheme.spaceXS,
              ),
              child: Wrap(
                spacing: BrandTheme.spaceXS,
                runSpacing: 0,
                children: buttons,
              ),
            );
          },
        ),
      );
}

class _TerminalTabButton extends StatelessWidget {
  const _TerminalTabButton({
    required this.tab,
    required this.selected,
    required this.onPressed,
  });

  final _TerminalTab tab;
  final bool selected;
  final VoidCallback onPressed;

  String get _label => switch (tab) {
        _TerminalTab.ai => 'ai',
        _TerminalTab.about => 'about',
        _TerminalTab.skills => 'skills',
        _TerminalTab.projects => 'projects',
        _TerminalTab.certifications => 'certifications',
        _TerminalTab.contact => 'contact',
      };

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: BrandTheme.spaceXS),
        child: Semantics(
          button: true,
          selected: selected,
          child: TextButton(
            key: Key('terminal-tab-$_label'),
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: selected
                  ? TerminalColors.green
                  : TerminalColors.textSecondary,
              textStyle: BrandTextStyles.mono(
                fontSize: 13,
                weight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(0, 46),
              shape: const RoundedRectangleBorder(),
            ),
            child: Text(
              _label,
              style: BrandTextStyles.mono(
                fontSize: 13,
                weight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? TerminalColors.green
                    : TerminalColors.textSecondary,
              ),
            ),
          ),
        ),
      );
}

class _WelcomeOutput extends StatelessWidget {
  const _WelcomeOutput({
    required this.role,
    required this.profile,
    required this.showHelp,
    required this.onRunHelp,
    required this.onOpenContact,
    required this.onDownloadCv,
  });

  final String role;
  final String profile;
  final bool showHelp;
  final VoidCallback onRunHelp;
  final VoidCallback onOpenContact;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(BrandTheme.space2XL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              showHelp ? 'Available commands' : 'Kharold Canova',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: TerminalColors.textPrimary,
                  ),
            ),
            const SizedBox(height: BrandTheme.spaceSM),
            if (showHelp)
              Text(
                'ai  about  skills  projects  certifications  contact',
                style: BrandTextStyles.mono(
                  fontSize: 14,
                  color: TerminalColors.yellow,
                ),
              )
            else ...[
              Text(
                role,
                style: BrandTextStyles.mono(
                  fontSize: 16,
                  color: TerminalColors.cyan,
                ),
              ),
              const SizedBox(height: BrandTheme.spaceLG),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  profile,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: TerminalColors.textSecondary,
                      ),
                ),
              ),
            ],
            const SizedBox(height: BrandTheme.spaceXL),
            Wrap(
              spacing: BrandTheme.spaceMD,
              runSpacing: BrandTheme.spaceSM,
              children: [
                OutlinedButton.icon(
                  onPressed: onRunHelp,
                  icon: const Icon(Icons.terminal, size: 16),
                  label: Text(showHelp ? 'whoami' : 'help'),
                ),
                ElevatedButton.icon(
                  onPressed: onOpenContact,
                  icon: const Icon(Icons.mail_outline, size: 16),
                  label: Text(AppLocalizations.of(context)!.contact_me),
                ),
                TextButton.icon(
                  key: const Key('terminal-welcome-cv'),
                  onPressed: onDownloadCv,
                  icon: const Icon(Icons.download_outlined, size: 16),
                  label: Text(AppLocalizations.of(context)!.download_cv),
                ),
              ],
            ),
          ],
        ),
      );
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks({required this.repository});

  final PortfolioRepository repository;

  @override
  Widget build(BuildContext context) {
    final links = <({String command, String label, String url})>[
      (command: 'github', label: 'GitHub', url: repository.getGithub()),
      (command: 'linkedin', label: 'LinkedIn', url: repository.getLinkedin()),
      if (repository.getMedium() case final medium?)
        (command: 'medium', label: 'Medium', url: medium),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BrandTheme.gutterMobile,
        0,
        BrandTheme.gutterMobile,
        BrandTheme.spaceXL,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = BrandTheme.spaceSM;
          final columns = constraints.maxWidth >= 700
              ? 3
              : constraints.maxWidth >= 420
                  ? 2
                  : 1;
          final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
          const icons = <String, IconData>{
            'github': Icons.code,
            'linkedin': Icons.work_outline,
            'medium': Icons.article_outlined,
          };
          const colors = <String, Color>{
            'github': TerminalColors.green,
            'linkedin': TerminalColors.cyan,
            'medium': TerminalColors.magenta,
          };

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (final link in links)
                SizedBox(
                  width: width,
                  height: 76,
                  child: OutlinedButton(
                    key: Key('terminal-contact-${link.command}'),
                    onPressed: () => launchUrl(
                      Uri.parse(link.url),
                      mode: LaunchMode.externalApplication,
                      webOnlyWindowName: '_blank',
                    ),
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                        horizontal: BrandTheme.spaceMD,
                      ),
                      foregroundColor: TerminalColors.textPrimary,
                      backgroundColor: TerminalColors.bgElevated,
                      side: const BorderSide(color: TerminalColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(BrandTheme.radius),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(icons[link.command], color: colors[link.command]),
                        const SizedBox(width: BrandTheme.spaceSM),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                link.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: BrandTextStyles.mono(
                                  fontSize: 12,
                                  weight: FontWeight.w600,
                                  color: TerminalColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: BrandTheme.spaceXS),
                              Text(
                                './${link.command}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: BrandTextStyles.mono(
                                  fontSize: 10,
                                  color: TerminalColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.north_east,
                          size: 15,
                          color: colors[link.command],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: BrandTheme.spaceMD,
          vertical: BrandTheme.spaceSM,
        ),
        decoration: const BoxDecoration(
          color: TerminalColors.bgElevated,
          border: Border(
            top: BorderSide(color: TerminalColors.border, width: 1),
          ),
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: BrandTextStyles.mono(
            fontSize: 10,
            color: TerminalColors.textSecondary,
          ),
        ),
      );
}

class _ScanlinePainter extends CustomPainter {
  const _ScanlinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var y = 3.0; y < size.height; y += 5) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_ScanlinePainter oldDelegate) =>
      oldDelegate.color != color;
}
