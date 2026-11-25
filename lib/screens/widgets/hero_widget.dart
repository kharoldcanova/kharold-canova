import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/availability_pill.dart';
import 'package:kharoldcanova/screens/widgets/neural_networks.dart';
import 'package:url_launcher/url_launcher.dart';

/// Hero (DESIGN.md 2.5, 3.2): identity on the left, the neural networks on
/// the right; they stack below 920px. Height follows the content.
class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.cvUrl,
    required this.onViewProjects,
  });

  final String cvUrl;
  final VoidCallback onViewProjects;

  static const double twoColumnWidth = 920;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= twoColumnWidth;
    // Same gutters as SectionContainer so every block shares one left edge.
    final gutter =
        width < 900 ? BrandTheme.gutterMobile : BrandTheme.gutterDesktop;

    final identity = _Identity(
      cvUrl: cvUrl,
      onViewProjects: onViewProjects,
      compact: width < 600,
    );
    const networks = NeuralNetworksPanel();

    return Container(
      key: const Key('hero-background'),
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(
        gutter,
        BrandTheme.headerHeight + (isWide ? 72 : 32),
        gutter,
        isWide ? 72 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: BrandTheme.contentMaxWidth),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: identity),
                    const SizedBox(width: 56),
                    const Expanded(child: networks),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    identity,
                    const SizedBox(height: 36),
                    networks,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({
    required this.cvUrl,
    required this.onViewProjects,
    required this.compact,
  });

  final String cvUrl;
  final VoidCallback onViewProjects;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final repo = PortfolioRepository();
    final accent = TextStyle(color: colorScheme.primary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: BrandTheme.spaceSM,
          runSpacing: BrandTheme.spaceSM,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              t.hero_greeting.toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.4,
              ),
            ),
            const AvailabilityPill(key: Key('hero-availability')),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Kharold Canova',
          key: const Key('hero-name'),
          style: TextStyle(
            fontSize: compact ? 42 : 68,
            fontWeight: FontWeight.w600,
            height: 1.02,
            letterSpacing: compact ? -1.2 : -2,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${t.hero_role_lead} '),
              TextSpan(text: 'Flutter', style: accent),
              TextSpan(text: ' ${t.hero_role_and} '),
              TextSpan(text: t.hero_role_ai, style: accent),
              const TextSpan(text: '.'),
            ],
          ),
          style: TextStyle(
            fontSize: compact ? 18 : 21,
            fontWeight: FontWeight.w500,
            height: 1.35,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            t.hero_value,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: BrandTheme.spaceMD,
          runSpacing: BrandTheme.spaceSM,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              key: const Key('hero-projects'),
              onPressed: onViewProjects,
              child: Text(t.hero_view_projects),
            ),
            _TextLink(
              key: const Key('hero-cv'),
              label: '${t.download_cv} ↗',
              color: colorScheme.primary,
              url: Uri.base.resolve(cvUrl),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: BrandTheme.spaceSM,
          children: [
            _TextLink(
              key: const Key('hero-github'),
              label: 'GitHub ↗',
              color: colorScheme.onSurfaceVariant,
              url: Uri.parse(repo.getGithub()),
            ),
            _TextLink(
              key: const Key('hero-linkedin'),
              label: 'LinkedIn ↗',
              color: colorScheme.onSurfaceVariant,
              url: Uri.parse(repo.getLinkedin()),
            ),
            if (repo.getMedium() != null)
              _TextLink(
                key: const Key('hero-medium'),
                label: 'Medium ↗',
                color: colorScheme.onSurfaceVariant,
                url: Uri.parse(repo.getMedium()!),
              ),
          ],
        ),
      ],
    );
  }
}

class _TextLink extends StatelessWidget {
  const _TextLink({
    super.key,
    required this.label,
    required this.color,
    required this.url,
  });

  final String label;
  final Color color;
  final Uri url;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      ),
      style: TextButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(0, 40),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      child: Text(label),
    );
  }
}
