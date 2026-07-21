import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    final services = [
      _ServiceData(icon: Icons.phone_android, label: t.service_android),
      _ServiceData(icon: Icons.phone_iphone, label: t.service_ios),
      _ServiceData(icon: Icons.web, label: t.service_web),
      _ServiceData(icon: Icons.rocket_launch, label: t.service_rag),
      _ServiceData(icon: Icons.psychology, label: t.service_scripts),
      _ServiceData(icon: Icons.auto_awesome, label: t.service_contact),
    ];

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
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: services.map((s) => _ServiceCard(data: s, colorScheme: colorScheme)).toList(),
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

  const _ServiceCard({required this.data, required this.colorScheme});

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
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 280,
        height: 200,
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
              size: 46,
              color: _hovered ? colorScheme.onSurface : Colors.white,
            ),
            const SizedBox(height: 16),
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
