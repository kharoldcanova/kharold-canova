import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final baseTheme = Theme.of(context);
    final colorScheme = baseTheme.colorScheme;
    final isDark = baseTheme.brightness == Brightness.dark;
    final sectionForeground = isDark ? Colors.white : colorScheme.onPrimary;
    final sectionBackground =
        isDark ? BrandColors.darkContactBackground : colorScheme.primary;
    final repo = PortfolioRepository();

    // Light mode keeps the blue contact block. Dark mode instead uses a
    // deep-green terminal panel with white text for accessible contrast.
    final contactTheme = baseTheme.copyWith(
      colorScheme: colorScheme.copyWith(
        primary: sectionForeground,
        surface: Colors.transparent,
        onSurface: sectionForeground,
        onSurfaceVariant: sectionForeground.withValues(alpha: 0.82),
        outline: sectionForeground.withValues(alpha: 0.4),
        outlineVariant: sectionForeground.withValues(alpha: 0.4),
      ),
      textTheme: baseTheme.textTheme.apply(
        bodyColor: sectionForeground,
        displayColor: sectionForeground,
      ),
    );

    return Theme(
      data: contactTheme,
      child: SectionContainer(
        background: sectionBackground,
        topBorder: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              index: '05',
              title: t.contact,
              description: t.contact_desc,
            ),
            const SizedBox(height: BrandTheme.spaceXL),
            Text(
              t.work_with_me,
              style: contactTheme.textTheme.headlineLarge,
            ),
            const SizedBox(height: BrandTheme.spaceXL),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 760;
                final cards = [
                  _ContactCard(
                    icon: Icons.email_outlined,
                    label: t.email,
                    value: repo.getEmail(),
                    onTap: () => launchUrl(
                      Uri.https('mail.google.com', '/mail/', {
                        'view': 'cm',
                        'fs': '1',
                        'to': repo.getEmail(),
                      }),
                      mode: LaunchMode.externalApplication,
                      webOnlyWindowName: '_blank',
                    ),
                  ),
                  _ContactCard(
                    icon: Icons.phone_outlined,
                    label: t.phones,
                    value: repo.getPhone(),
                    onTap: () => launchUrl(
                      Uri(
                        scheme: 'tel',
                        path: repo.getPhone().replaceAll(' ', ''),
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ];

                if (!isWide) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      cards.first,
                      const SizedBox(height: BrandTheme.spaceMD),
                      cards.last,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: cards.first),
                    const SizedBox(width: BrandTheme.spaceMD),
                    Expanded(child: cards.last),
                  ],
                );
              },
            ),
            const SizedBox(height: BrandTheme.spaceXL),
            Text(
              t.profile_expertise,
              style: BrandTextStyles.mono(
                fontSize: 12,
                color: contactTheme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor =
        _hovered || _focused ? colorScheme.primary : colorScheme.outline;

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.enter): widget.onTap,
        const SingleActivator(LogicalKeyboardKey.space): widget.onTap,
      },
      child: Focus(
        onFocusChange: (value) => setState(() => _focused = value),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(BrandTheme.spaceLG),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(BrandTheme.radius),
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: BrandTheme.spaceMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label.toUpperCase(),
                          style: BrandTextStyles.mono(
                            fontSize: 11,
                            color: colorScheme.onSurfaceVariant,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: BrandTheme.spaceXS),
                        Text(
                          widget.value,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
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
