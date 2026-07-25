import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

// ---------------------------------------------------------------------------
// Data Model
// ---------------------------------------------------------------------------

class CertificationItem {
  final String title;
  final String subtitle;
  final String date;
  final Color color;
  final IconData icon;

  const CertificationItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.color,
    required this.icon,
  });
}

// ---------------------------------------------------------------------------
// Widget: CertificationsSection
// ---------------------------------------------------------------------------

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1200;
    final horizontalPadding = isDesktop ? 80.0 : 24.0;
    final certifications = PortfolioRepository().getCertifications();

    return AnimateOnVisible(
      builder: (context, visible) {
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 60,
            ),
            child: Column(
              children: [
                // -- Title
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    t.certifications_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    t.certifications_subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: cs.onSurface.withAlpha(180),
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // -- Responsive grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 1100
                        ? 3
                        : constraints.maxWidth > 600
                            ? 2
                            : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 2.4,
                      ),
                      itemCount: certifications.length,
                      itemBuilder: (context, index) {
                        return _CertificationCard(
                          certification: certifications[index],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Card Widget — solid color background, white text
// ---------------------------------------------------------------------------

class _CertificationCard extends StatefulWidget {
  final CertificationItem certification;

  const _CertificationCard({required this.certification});

  @override
  State<_CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cert = widget.certification;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _hovered
            ? (Matrix4.identity()..translateByDouble(0.0, -4.0, 0.0, 1.0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cert.color,
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: cert.color.withValues(alpha: _hovered ? 0.35 : 0.20),
              blurRadius: _hovered ? 20 : 10,
              offset: Offset(0, _hovered ? 8 : 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // -- Icon
              Icon(cert.icon, color: Colors.white, size: 54),
              const SizedBox(width: 16),

              // -- Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cert.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cert.subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cert.date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
