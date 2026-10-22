import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioDrawer extends StatelessWidget {
  const PortfolioDrawer({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.onClose,
    this.onPresentationTap,
    required this.cvUrl,
    this.mediumUrl,
  });

  final String activeSection;
  final ValueChanged<String> onSectionTap;
  final VoidCallback onClose;
  final VoidCallback? onPresentationTap;
  final String cvUrl;
  final String? mediumUrl;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final isDark = context.watch<ThemeBloc>().state.isDark;

    final items = <({String id, String label, IconData icon})>[
      (id: 'home', label: t.home, icon: Icons.home_outlined),
      (id: 'about', label: t.about, icon: Icons.person_outline),
      (id: 'projects', label: t.projects, icon: Icons.work_outline),
      (
        id: 'certifications',
        label: t.certifications,
        icon: Icons.workspace_premium_outlined,
      ),
      (id: 'contact', label: t.contact, icon: Icons.mail_outline),
    ];

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.escape): onClose,
          },
          child: Focus(
            autofocus: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    BrandTheme.spaceLG,
                    BrandTheme.spaceLG,
                    BrandTheme.spaceLG,
                    BrandTheme.spaceMD,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kharold Canova',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: BrandTheme.spaceXS),
                      Text(
                        t.hero_subtitle,
                        style: BrandTextStyles.mono(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: tokens.borderSubtle),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: BrandTheme.spaceSM,
                    ),
                    children: [
                      for (final item in items)
                        _DrawerNavItem(
                          label: item.label,
                          icon: item.icon,
                          isActive: activeSection == item.id,
                          onTap: () {
                            onClose();
                            onSectionTap(item.id);
                          },
                        ),
                      ListTile(
                        leading: const Icon(Icons.play_arrow),
                        title: Text(t.presentation_mode),
                        onTap: () {
                          onClose();
                          onPresentationTap?.call();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: tokens.borderSubtle),
                Padding(
                  padding: const EdgeInsets.all(BrandTheme.spaceMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          if (mediumUrl != null)
                            IconButton(
                              tooltip: t.medium,
                              onPressed: () => launchUrl(
                                Uri.parse(mediumUrl!),
                                mode: LaunchMode.externalApplication,
                                webOnlyWindowName: '_blank',
                              ),
                              icon: FaIcon(
                                FontAwesomeIcons.medium,
                                size: 18,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          IconButton(
                            tooltip: isDark ? t.theme_light : t.theme_dark,
                            onPressed: () => context
                                .read<ThemeBloc>()
                                .add(const ToggleTheme()),
                            icon: Icon(
                              isDark
                                  ? Icons.light_mode_outlined
                                  : Icons.dark_mode_outlined,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Tooltip(
                            message: t.change_language,
                            child: TextButton(
                              onPressed: () {
                                final bloc = context.read<LanguageBloc>();
                                final current = bloc.state.selectedLanguage;
                                bloc.add(
                                  ChangeLanguage(
                                    selectedLanguage:
                                        current == Language.english
                                            ? Language.spanish
                                            : Language.english,
                                  ),
                                );
                              },
                              child: Text(
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? 'EN / ES'
                                    : 'ES / EN',
                                style: BrandTextStyles.mono(
                                  fontSize: 12,
                                  weight: FontWeight.w500,
                                  letterSpacing: 0.6,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: BrandTheme.spaceSM),
                      ElevatedButton.icon(
                        onPressed: () => launchUrl(
                          Uri.base.resolve(cvUrl),
                          mode: LaunchMode.externalApplication,
                          webOnlyWindowName: '_blank',
                        ),
                        icon: const Icon(Icons.download_outlined, size: 18),
                        label: Text(t.download_cv),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerNavItem extends StatelessWidget {
  const _DrawerNavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isActive ? colorScheme.primary : colorScheme.onSurface;

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(color),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return colorScheme.primary.withValues(alpha: 0.08);
            }
            return null;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: colorScheme.primary, width: 2);
            }
            return BorderSide.none;
          }),
          alignment: const Alignment(-1, 0),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: BrandTheme.spaceLG,
              vertical: BrandTheme.spaceMD,
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(0, 52)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BrandTheme.radiusSM),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color:
                  isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: BrandTheme.spaceMD),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
