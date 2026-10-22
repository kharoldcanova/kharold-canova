import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
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
    required this.height,
  });

  final String cvUrl;
  final VoidCallback onContact;
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 1200;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final image =
        isMobile ? 'assets/hero-mobile.webp' : 'assets/hero-desktop.webp';
    final heroFont = isDark ? BrandTheme.monoFamily : BrandTheme.fontFamily;

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
          if (isDark)
            const ColoredBox(color: Colors.black)
          else ...[
            Image.asset(
              image,
              fit: BoxFit.cover,
              alignment: isMobile ? Alignment.center : Alignment.centerRight,
              errorBuilder: (context, error, stackTrace) {
                return ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                );
              },
            ),
          ],
          Align(
            alignment: isMobile ? Alignment.centerLeft : Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontal,
                0,
                horizontal,
                isMobile ? BrandTheme.space2XL : 96,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? 460 : 820,
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
                          color: tokens.onImage,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isMobile
                          ? BrandTheme.spaceSM
                          : BrandTheme.spaceSM + 4,
                    ),
                    Text(
                      t.hero_subtitle,
                      style: TextStyle(
                        fontFamily: heroFont,
                        fontSize: roleSize,
                        height: 1.1,
                        fontWeight: FontWeight.w400,
                        letterSpacing: isMobile ? 0 : -0.5,
                        color: tokens.onImageMuted,
                      ),
                    ),
                    SizedBox(
                      height:
                          isMobile ? BrandTheme.spaceLG : BrandTheme.spaceXL,
                    ),
                    Wrap(
                      spacing: BrandTheme.spaceSM + 4,
                      runSpacing: BrandTheme.spaceSM + 4,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => launchUrl(
                            Uri.base.resolve(cvUrl),
                            mode: LaunchMode.externalApplication,
                            webOnlyWindowName: '_blank',
                          ),
                          icon: const Icon(Icons.download_outlined, size: 18),
                          label: Text(t.download_cv),
                        ),
                        OutlinedButton.icon(
                          onPressed: onContact,
                          icon: const Icon(Icons.mail_outline, size: 18),
                          label: Text(t.contact_me),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: tokens.onImage,
                            side: BorderSide(
                              color: tokens.onImageBorder,
                              width: 1,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
