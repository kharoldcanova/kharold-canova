import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
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
                icon: Icons.mail_outline,
                tooltip: repo.getEmail(),
                onTap: () {},
                colorScheme: colorScheme,
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                icon: Icons.alternate_email,
                tooltip: 'GitHub',
                onTap: () => launchUrl(Uri.parse(repo.getGithub())),
                colorScheme: colorScheme,
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                icon: Icons.work_outline,
                tooltip: 'LinkedIn',
                onTap: () => launchUrl(Uri.parse(repo.getLinkedin())),
                colorScheme: colorScheme,
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
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.colorScheme,
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
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
