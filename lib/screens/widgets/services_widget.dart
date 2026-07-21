import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;

    final services = [
      _ServiceData(icon: Icons.android, label: t.service_android),
      _ServiceData(icon: Icons.apple, label: t.service_ios),
      _ServiceData(icon: Icons.html, label: t.service_web),
      _ServiceData(icon: Icons.rocket_launch, label: t.service_rag),
      _ServiceData(icon: Icons.psychology, label: t.service_scripts),
      _ServiceData(icon: Icons.terminal, label: t.service_contact),
    ];

    // Ancho fijo por card para mantener exactamente 3 columnas en escritorio
    final double cardWidth = isSmallScreen ? (screenWidth - 48) : 280.0;
    final double cardHeight = 260.0; // Altura incrementada

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 60,
      ),
      child: Column(
        children: [
          Text(
            t.services_title,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 40),
          // Constreñimos el contenedor para asegurar que máximo entren 3 columnas (280*3 + espaciados)
          SizedBox(
            width: isSmallScreen ? double.infinity : (280.0 * 3) + (20.0 * 2),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: services
                  .map(
                    (s) => _ServiceCard(
                      data: s,
                      colorScheme: colorScheme,
                      width: cardWidth,
                      height: cardHeight,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceData {
  final IconData icon;
  final String label;
  const _ServiceData({required this.icon, required this.label});
}

class _ServiceCard extends StatefulWidget {
  final _ServiceData data;
  final ColorScheme colorScheme;
  final double width;
  final double height;

  const _ServiceCard({
    required this.data,
    required this.colorScheme,
    required this.width,
    required this.height,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final colorScheme = widget.colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _hovered ? Colors.transparent : colorScheme.primary,
          border: _hovered
              ? Border.all(color: colorScheme.onSurface.withAlpha(60))
              : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.icon,
              size: 50,
              color: _hovered ? colorScheme.onSurface : Colors.white,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                data.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _hovered ? colorScheme.onSurface : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
