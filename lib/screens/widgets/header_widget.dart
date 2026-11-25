import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Width at which the header switches from the drawer to inline links.
const double kHeaderInlineNavWidth = 900;

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.isOverHero,
    required this.onMenuTap,
    this.cvUrl,
    this.menuFocusNode,
  });

  final String activeSection;
  final ValueChanged<String> onSectionTap;
  final bool isOverHero;
  final VoidCallback onMenuTap;
  final String? cvUrl;
  final FocusNode? menuFocusNode;

  @override
  Size get preferredSize => const Size.fromHeight(BrandTheme.headerHeight);

  /// The four destinations shown in the header (DESIGN.md 3.3).
  static List<({String id, String label})> navItems(AppLocalizations t) => [
        (id: 'about', label: t.about),
        (id: 'experience', label: t.nav_experience),
        (id: 'projects', label: t.projects),
        (id: 'contact', label: t.contact),
      ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= kHeaderInlineNavWidth;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = colorScheme.onSurface;
    final background = isOverHero ? Colors.transparent : tokens.navSurface;
    final borderColor = isOverHero ? Colors.transparent : tokens.borderSubtle;

    return Material(
      type: MaterialType.transparency,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: BrandTheme.headerHeight,
        decoration: BoxDecoration(
          color: background,
          border: Border(bottom: BorderSide(color: borderColor, width: 1)),
        ),
        // Same gutters and max width as the sections, so the brand lines
        // up with the content below it.
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width < 900
                ? BrandTheme.gutterMobile - BrandTheme.spaceSM
                : BrandTheme.gutterDesktop,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: BrandTheme.contentMaxWidth,
              ),
              child: Row(
                children: [
                  _Brand(
                    // Phones keep the monogram only so the actions fit.
                    showName: width >= 480,
                    onTap: () => onSectionTap('home'),
                  ),
                  if (isWide)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final item in navItems(t))
                                _NavLink(
                                  label: item.label,
                                  isActive: activeSection == item.id,
                                  onTap: () => onSectionTap(item.id),
                                ),
                              const SizedBox(width: BrandTheme.spaceMD),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    const Spacer(),
                  _LanguageButton(color: foreground),
                  _ThemeButton(color: foreground),
                  if (cvUrl != null) ...[
                    const SizedBox(width: BrandTheme.spaceXS),
                    _CvButton(cvUrl: cvUrl!),
                  ],
                  if (!isWide)
                    IconButton(
                      key: const Key('menu-button'),
                      focusNode: menuFocusNode,
                      tooltip: t.menu,
                      onPressed: onMenuTap,
                      color: foreground,
                      icon: const Icon(Icons.menu),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "KC" monogram plus the name; returns to the top of the page.
class _Brand extends StatelessWidget {
  const _Brand({required this.showName, required this.onTap});

  final bool showName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: 'Kharold Canova',
      child: InkWell(
        key: const Key('header-brand'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(BrandTheme.radius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: BrandTheme.spaceSM),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(BrandTheme.radius),
                ),
                child: Text(
                  'KC',
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (showName) ...[
                const SizedBox(width: 10),
                Text(
                  'Kharold Canova',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined "CV" button that opens the PDF in the site language.
class _CvButton extends StatelessWidget {
  const _CvButton({required this.cvUrl});

  final String cvUrl;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Tooltip(
      message: t.download_cv,
      child: OutlinedButton(
        key: const Key('header-cv'),
        onPressed: () => launchUrl(
          Uri.base.resolve(cvUrl),
          mode: LaunchMode.externalApplication,
          webOnlyWindowName: '_blank',
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        child: const Text('CV ↗'),
      ),
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
          EdgeInsets.symmetric(horizontal: 10),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
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
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
