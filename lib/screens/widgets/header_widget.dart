import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.isOverHero,
    required this.onMenuTap,
    this.onPresentationTap,
    this.mediumUrl,
    this.cvUrl,
    this.menuFocusNode,
  });

  final String activeSection;
  final ValueChanged<String> onSectionTap;
  final bool isOverHero;
  final VoidCallback onMenuTap;
  final VoidCallback? onPresentationTap;
  final String? mediumUrl;
  final String? cvUrl;
  final FocusNode? menuFocusNode;

  @override
  Size get preferredSize => const Size.fromHeight(BrandTheme.headerHeight);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final repo = PortfolioRepository();
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1200;
    final showPresentation = width >= 1280;
    final showMedium = width >= 1360;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = colorScheme.onSurface;
    final background = isOverHero ? Colors.transparent : tokens.navSurface;
    final borderColor = isOverHero ? Colors.transparent : colorScheme.outline;

    final items = <({String id, String label})>[
      (id: 'home', label: t.home),
      (id: 'about', label: t.about),
      (id: 'experience', label: t.nav_experience),
      (id: 'projects', label: t.projects),
      (id: 'certifications', label: t.nav_education),
      (id: 'contact', label: t.contact),
    ];

    return Material(
      type: MaterialType.transparency,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: BrandTheme.headerHeight,
        decoration: BoxDecoration(
          color: background,
          border: Border(
            bottom: BorderSide(color: borderColor, width: 1),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? BrandTheme.gutterDesktop : 16,
          ),
          child: isDesktop
              ? Row(
                  children: [
                    // Nav links take the free space and only scale down
                    // when the labels do not fit next to the actions.
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final item in items)
                                _NavLink(
                                  label: item.label,
                                  isActive: activeSection == item.id,
                                  onTap: () => onSectionTap(item.id),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _HeaderIconButton(
                      key: const Key('header-github'),
                      tooltip: 'GitHub',
                      icon: const FaIcon(
                        FontAwesomeIcons.github,
                        size: 18,
                      ),
                      color: foreground,
                      onPressed: () => launchUrl(
                        Uri.parse(repo.getGithub()),
                        mode: LaunchMode.externalApplication,
                        webOnlyWindowName: '_blank',
                      ),
                    ),
                    _HeaderIconButton(
                      key: const Key('header-linkedin'),
                      tooltip: 'LinkedIn',
                      icon: const FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 18,
                      ),
                      color: foreground,
                      onPressed: () => launchUrl(
                        Uri.parse(repo.getLinkedin()),
                        mode: LaunchMode.externalApplication,
                        webOnlyWindowName: '_blank',
                      ),
                    ),
                    if (cvUrl != null)
                      _HeaderIconButton(
                        key: const Key('header-cv'),
                        tooltip: t.download_cv,
                        icon: const Icon(Icons.description_outlined, size: 19),
                        color: foreground,
                        onPressed: () => launchUrl(
                          Uri.base.resolve(cvUrl!),
                          mode: LaunchMode.externalApplication,
                          webOnlyWindowName: '_blank',
                        ),
                      ),
                    if (mediumUrl != null && showMedium)
                      _HeaderIconButton(
                        tooltip: t.medium,
                        icon: const FaIcon(
                          FontAwesomeIcons.medium,
                          size: 18,
                        ),
                        color: foreground,
                        onPressed: () => launchUrl(
                          Uri.parse(mediumUrl!),
                          mode: LaunchMode.externalApplication,
                          webOnlyWindowName: '_blank',
                        ),
                      ),
                    if (showPresentation)
                      _HeaderIconButton(
                        key: const Key('presentation-control'),
                        tooltip: t.presentation_mode,
                        icon: const Icon(Icons.play_arrow),
                        color: foreground,
                        onPressed: onPresentationTap ?? () {},
                      ),
                    _ThemeButton(color: foreground),
                    _LanguageButton(color: foreground),
                  ],
                )
              : Row(
                  children: [
                    IconButton(
                      key: const Key('menu-button'),
                      focusNode: menuFocusNode,
                      tooltip: t.menu,
                      onPressed: onMenuTap,
                      color: foreground,
                      icon: const Icon(Icons.menu),
                      style: _iconButtonStyle(foreground),
                    ),
                    const Spacer(),
                    _ThemeButton(color: foreground),
                  ],
                ),
        ),
      ),
    );
  }

  ButtonStyle _iconButtonStyle(Color color) {
    return ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(color),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return color.withValues(alpha: 0.18);
        }
        if (states.contains(WidgetState.hovered)) {
          return color.withValues(alpha: 0.08);
        }
        return null;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: color, width: 2);
        }
        return BorderSide.none;
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BrandTheme.radius),
        ),
      ),
      minimumSize: const WidgetStatePropertyAll(Size(40, 40)),
      padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.onSurface;
    final activeColor = colorScheme.primary;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return color.withValues(alpha: 0.16);
          }
          if (states.contains(WidgetState.hovered)) {
            return color.withValues(alpha: 0.08);
          }
          return null;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: color, width: 2);
          }
          return BorderSide.none;
        }),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
        minimumSize: const WidgetStatePropertyAll(
          Size(0, BrandTheme.headerHeight),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radiusSM),
          ),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: Theme.of(context).textTheme.labelLarge?.fontFamily ??
                BrandTheme.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.only(top: 2, bottom: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? activeColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final isDark = context.watch<ThemeBloc>().state.isDark;

    return IconButton(
      key: const Key('theme-toggle'),
      tooltip: isDark ? t.theme_light : t.theme_dark,
      onPressed: () => context.read<ThemeBloc>().add(const ToggleTheme()),
      color: color,
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
      ),
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return color.withValues(alpha: 0.18);
          }
          if (states.contains(WidgetState.hovered)) {
            return color.withValues(alpha: 0.08);
          }
          return null;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: color, width: 2);
          }
          return BorderSide.none;
        }),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(40, 40)),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isEnglish = locale.languageCode == 'en';

    return Tooltip(
      message: t.change_language,
      child: TextButton(
        key: const Key('language-toggle'),
        onPressed: () {
          final bloc = context.read<LanguageBloc>();
          bloc.add(
            ChangeLanguage(
              selectedLanguage: isEnglish ? Language.spanish : Language.english,
            ),
          );
        },
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(color),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return color.withValues(alpha: 0.18);
            }
            if (states.contains(WidgetState.hovered)) {
              return color.withValues(alpha: 0.08);
            }
            return null;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: color, width: 2);
            }
            return BorderSide.none;
          }),
          textStyle: WidgetStatePropertyAll(
            BrandTextStyles.mono(
              fontSize: 12,
              weight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(44, 40)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 8),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BrandTheme.radius),
            ),
          ),
        ),
        child: Text(isEnglish ? 'EN' : 'ES'),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String tooltip;
  final Widget icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: key,
      tooltip: tooltip,
      onPressed: onPressed,
      color: color,
      icon: icon,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(color),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return color.withValues(alpha: 0.18);
          }
          if (states.contains(WidgetState.hovered)) {
            return color.withValues(alpha: 0.08);
          }
          return null;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return BorderSide(color: color, width: 2);
          }
          return BorderSide.none;
        }),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(40, 40)),
      ),
    );
  }
}
