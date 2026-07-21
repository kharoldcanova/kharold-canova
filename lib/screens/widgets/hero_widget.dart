import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    final isSmall = width < 600;
    final isMedium = width >= 600 && width < 900;

    final nameSize = isSmall ? 36.0 : (isMedium ? 56.0 : 80.0);
    final subtitleSize = isSmall ? 20.0 : (isMedium ? 30.0 : 38.0);
    final avatarRadius = isSmall ? 100.0 : (isMedium ? 140.0 : 220.0);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: isSmall
          ? _mobileLayout(t, colorScheme, nameSize, subtitleSize, avatarRadius)
          : _desktopLayout(
              t, colorScheme, nameSize, subtitleSize, avatarRadius),
    );
  }

  Widget _desktopLayout(
    AppLocalizations t,
    ColorScheme colorScheme,
    double nameSize,
    double subtitleSize,
    double avatarRadius,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child:
                _heroText(t, colorScheme, nameSize, subtitleSize),
          ),
          Expanded(
            flex: 4,
            child: _heroPhoto(colorScheme, avatarRadius),
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout(
    AppLocalizations t,
    ColorScheme colorScheme,
    double nameSize,
    double subtitleSize,
    double avatarRadius,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _heroPhoto(colorScheme, avatarRadius),
          const SizedBox(height: 40),
          _heroText(t, colorScheme, nameSize, subtitleSize),
        ],
      ),
    );
  }

  Widget _heroText(
    AppLocalizations t,
    ColorScheme colorScheme,
    double nameSize,
    double subtitleSize,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kharold Canova',
          style: TextStyle(
            fontSize: nameSize,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          t.hero_subtitle,
          style: TextStyle(
            fontSize: subtitleSize,
            color: colorScheme.onSurface.withAlpha(179),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32),
            ),
            child: Text(
              t.download_cv,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _heroPhoto(ColorScheme colorScheme, double radius) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: colorScheme.primary.withAlpha(60),
        backgroundImage: const AssetImage('assets/photo.jpg'),
      ),
    );
  }
}
