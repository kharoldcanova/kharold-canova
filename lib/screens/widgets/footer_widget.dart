import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;
    final repo = PortfolioRepository();

    return Container(
      color: colorScheme.primary.withAlpha(230),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 32,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                iconWidget: const Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                  size: 20,
                ),
                tooltip: repo.getEmail(),
                onTap: () => _openUrl(
                  'https://mail.google.com/mail/?view=cm&fs=1&to=${repo.getEmail()}',
                ),
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                iconWidget: const FaIcon(
                  FontAwesomeIcons.github,
                  color: Colors.white,
                  size: 20,
                ),
                tooltip: 'GitHub',
                onTap: () => _openUrl(repo.getGithub()),
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                iconWidget: const FaIcon(
                  FontAwesomeIcons.linkedin,
                  color: Colors.white,
                  size: 20,
                ),
                tooltip: 'LinkedIn',
                onTap: () => _openUrl(repo.getLinkedin()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© ${DateTime.now().year} Kharold Canova. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(179),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _SocialIcon extends StatelessWidget {
  final Widget iconWidget;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.iconWidget,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Center(child: iconWidget),
        ),
      ),
    );
  }
}
