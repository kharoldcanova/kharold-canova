import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Viewport fractions and bounds for the reduced hero height.
const double _mobileHeroFraction = 0.68;
const double _mobileHeroMinHeight = 500;
const double _mobileHeroMaxHeight = 600;
const double _desktopHeroFraction = 0.72;
const double _desktopHeroMinHeight = 540;
const double _desktopHeroMaxHeight = 700;

/// Shared hero height so the page's scroll/header detection matches the
/// rendered hero exactly.
double heroHeightFor(BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final isMobile = size.width < 1200;
  final target =
      size.height * (isMobile ? _mobileHeroFraction : _desktopHeroFraction);

  return target
      .clamp(
        isMobile ? _mobileHeroMinHeight : _desktopHeroMinHeight,
        isMobile ? _mobileHeroMaxHeight : _desktopHeroMaxHeight,
      )
      .toDouble();
}

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.cvUrl,
    required this.onContact,
    required this.onViewProjects,
    required this.height,
  });

  final String cvUrl;
  final VoidCallback onContact;
  final VoidCallback onViewProjects;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final repo = PortfolioRepository();
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 1200;
    final isCompact = width < 700;
    const heroFont = BrandTheme.fontFamily;

    // Plain background (DESIGN.md 3.2): the name, role and actions lead, so
    // the hero uses the regular ink roles at every width and in both modes.
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final heroForeground = colorScheme.onSurface;
    final heroMuted = colorScheme.onSurfaceVariant;
    final heroBorder = colorScheme.outline;

    final nameSize = isMobile ? 36.0 : 80.0;
    final roleSize = isMobile ? 20.0 : 38.0;
    final horizontal =
        isMobile ? BrandTheme.gutterMobile : BrandTheme.gutterDesktop;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(
            key: const Key('hero-background'),
            color: theme.scaffoldBackgroundColor,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontal,
                0,
                horizontal,
                isMobile ? BrandTheme.spaceLG : 80,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? 460 : 860,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        'Kharold Canova',
                        style: TextStyle(
                          fontFamily: heroFont,
                          fontSize: nameSize,
                          height: 1,
                          fontWeight: FontWeight.w500,
                          letterSpacing: isMobile ? -0.8 : -1.6,
                          color: heroForeground,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isMobile
                          ? BrandTheme.spaceSM
                          : BrandTheme.spaceSM + 4,
                    ),
                    Semantics(
                      header: true,
                      child: Text(
                        t.hero_subtitle,
                        style: TextStyle(
                          fontFamily: heroFont,
                          fontSize: roleSize,
                          height: 1.1,
                          fontWeight: FontWeight.w400,
                          letterSpacing: isMobile ? 0 : -0.5,
                          color: heroMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: BrandTheme.spaceSM + 4),
                    Text(
                      t.hero_eyebrow,
                      style: BrandTextStyles.mono(
                        fontSize: 11,
                        weight: FontWeight.w500,
                        color: heroMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(
                      height:
                          isMobile ? BrandTheme.spaceLG : BrandTheme.spaceXL,
                    ),
                    _HeroActions(
                      cvUrl: cvUrl,
                      foreground: heroForeground,
                      borderColor: heroBorder,
                      onContact: onContact,
                      onViewProjects: onViewProjects,
                      showContact: !isCompact,
                      showSocials: isMobile,
                      socialUrls: (
                        github: repo.getGithub(),
                        linkedin: repo.getLinkedin(),
                        email: repo.getEmail(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!isMobile)
            Positioned(
              right: BrandTheme.gutterDesktop,
              bottom: 80,
              child: _HeroSocialRail(
                foreground: heroForeground,
                borderColor: heroBorder,
                githubUrl: repo.getGithub(),
                linkedinUrl: repo.getLinkedin(),
                email: repo.getEmail(),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroActions extends StatelessWidget {
  const _HeroActions({
    required this.cvUrl,
    required this.foreground,
    required this.borderColor,
    required this.onContact,
    required this.onViewProjects,
    required this.showContact,
    required this.showSocials,
    required this.socialUrls,
  });

  final String cvUrl;
  final Color foreground;
  final Color borderColor;
  final VoidCallback onContact;
  final VoidCallback onViewProjects;
  final bool showContact;
  final bool showSocials;
  final ({String github, String linkedin, String email}) socialUrls;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Wrap(
      spacing: BrandTheme.spaceSM + 4,
      runSpacing: BrandTheme.spaceSM + 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElevatedButton.icon(
          key: const Key('hero-cv'),
          onPressed: () => launchUrl(
            Uri.base.resolve(cvUrl),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
          icon: const Icon(Icons.download_outlined, size: 18),
          label: Text(t.download_cv),
        ),
        OutlinedButton.icon(
          key: const Key('hero-projects'),
          onPressed: onViewProjects,
          icon: const Icon(Icons.arrow_downward, size: 18),
          label: Text(t.hero_view_projects),
          style: _outlinedSecondary(),
        ),
        if (showContact)
          OutlinedButton.icon(
            key: const Key('hero-contact'),
            onPressed: onContact,
            icon: const Icon(Icons.mail_outline, size: 18),
            label: Text(t.contact_me),
            style: _outlinedSecondary(),
          ),
        if (showSocials) ...[
          _HeroIconLink(
            key: const Key('hero-github'),
            tooltip: 'GitHub',
            color: foreground,
            borderColor: borderColor,
            icon: const FaIcon(FontAwesomeIcons.github, size: 18),
            onPressed: () => _open(socialUrls.github),
          ),
          _HeroIconLink(
            key: const Key('hero-linkedin'),
            tooltip: 'LinkedIn',
            color: foreground,
            borderColor: borderColor,
            icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
            onPressed: () => _open(socialUrls.linkedin),
          ),
        ],
      ],
    );
  }

  ButtonStyle _outlinedSecondary() {
    return OutlinedButton.styleFrom(
      foregroundColor: foreground,
      side: BorderSide(color: borderColor, width: 1),
      backgroundColor: Colors.transparent,
    );
  }

  void _open(String url) {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    );
  }
}

class _HeroSocialRail extends StatelessWidget {
  const _HeroSocialRail({
    required this.foreground,
    required this.borderColor,
    required this.githubUrl,
    required this.linkedinUrl,
    required this.email,
  });

  final Color foreground;
  final Color borderColor;
  final String githubUrl;
  final String linkedinUrl;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeroIconLink(
          key: const Key('hero-github-rail'),
          tooltip: 'GitHub',
          color: foreground,
          borderColor: borderColor,
          icon: const FaIcon(FontAwesomeIcons.github, size: 18),
          onPressed: () => launchUrl(
            Uri.parse(githubUrl),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
        ),
        const SizedBox(height: BrandTheme.spaceSM),
        _HeroIconLink(
          key: const Key('hero-linkedin-rail'),
          tooltip: 'LinkedIn',
          color: foreground,
          borderColor: borderColor,
          icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
          onPressed: () => launchUrl(
            Uri.parse(linkedinUrl),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
        ),
        const SizedBox(height: BrandTheme.spaceSM),
        _HeroIconLink(
          key: const Key('hero-email-rail'),
          tooltip: AppLocalizations.of(context)!.email,
          color: foreground,
          borderColor: borderColor,
          icon: const Icon(Icons.mail_outline, size: 18),
          onPressed: () => launchUrl(
            Uri(scheme: 'mailto', path: email),
            mode: LaunchMode.externalApplication,
          ),
        ),
      ],
    );
  }
}

class _HeroIconLink extends StatelessWidget {
  const _HeroIconLink({
    super.key,
    required this.tooltip,
    required this.color,
    required this.borderColor,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final Color color;
  final Color borderColor;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: color,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          foregroundColor: WidgetStatePropertyAll(color),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return color.withValues(alpha: 0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return color.withValues(alpha: 0.1);
            }
            return null;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return BorderSide(color: color, width: 2);
            }
            return BorderSide(color: borderColor, width: 1);
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BrandTheme.radius),
            ),
          ),
        ),
      ),
    );
  }
}
