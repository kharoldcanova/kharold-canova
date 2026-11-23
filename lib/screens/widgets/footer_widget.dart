import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key, this.mediumUrl, this.onTerminalTap});

  final String? mediumUrl;

  /// Opens the optional terminal easter egg; hidden when null.
  final VoidCallback? onTerminalTap;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final repo = PortfolioRepository();
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 760;

    final copyright = Text(
      '© ${DateTime.now().year} Kharold Canova. ${t.footer_rights}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
    );

    final socials = Wrap(
      spacing: BrandTheme.spaceSM,
      runSpacing: BrandTheme.spaceSM,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _SocialIcon(
          tooltip: t.email,
          icon: const Icon(Icons.mail_outline, size: 18),
          onTap: () => launchUrl(
            Uri(scheme: 'mailto', path: repo.getEmail()),
            mode: LaunchMode.externalApplication,
          ),
        ),
        _SocialIcon(
          tooltip: 'GitHub',
          icon: const FaIcon(FontAwesomeIcons.github, size: 18),
          onTap: () => launchUrl(
            Uri.parse(repo.getGithub()),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
        ),
        _SocialIcon(
          tooltip: 'LinkedIn',
          icon: const FaIcon(FontAwesomeIcons.linkedin, size: 18),
          onTap: () => launchUrl(
            Uri.parse(repo.getLinkedin()),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
        ),
        if (mediumUrl != null)
          _SocialIcon(
            tooltip: t.medium,
            icon: const FaIcon(FontAwesomeIcons.medium, size: 18),
            onTap: () => launchUrl(
              Uri.parse(mediumUrl!),
              mode: LaunchMode.externalApplication,
              webOnlyWindowName: '_blank',
            ),
          ),
        if (onTerminalTap != null)
          _SocialIcon(
            key: const Key('terminal-open'),
            tooltip: t.terminal_open,
            icon: Text(
              '>_',
              style: BrandTextStyles.mono(
                fontSize: 13,
                weight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            onTap: onTerminalTap!,
          ),
        OutlinedButton.icon(
          key: const Key('footer-cv'),
          onPressed: () => launchUrl(
            Uri.base.resolve(
                repo.getCvUrl(Localizations.localeOf(context).languageCode)),
            mode: LaunchMode.externalApplication,
            webOnlyWindowName: '_blank',
          ),
          icon: const Icon(Icons.download_outlined, size: 17),
          label: Text(t.footer_cv),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            side: BorderSide(color: colorScheme.outlineVariant, width: 1),
            minimumSize: const Size(0, 40),
            padding: const EdgeInsets.symmetric(
              horizontal: BrandTheme.spaceMD,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BrandTheme.radius),
            ),
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      color: colorScheme.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: BrandTheme.contentMaxWidth,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact
                  ? BrandTheme.gutterMobile
                  : BrandTheme.gutterDesktop,
              vertical: BrandTheme.spaceLG,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: BrandTheme.spaceLG),
                child: isCompact
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          copyright,
                          const SizedBox(height: BrandTheme.spaceMD),
                          socials,
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: copyright),
                          socials,
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

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(BrandTheme.radius),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BrandTheme.radius),
            border: Border.all(
              color: colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          child: IconTheme(
            data: IconThemeData(color: colorScheme.onSurface, size: 18),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
