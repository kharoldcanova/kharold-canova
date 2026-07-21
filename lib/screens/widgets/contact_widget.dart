import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final repo = PortfolioRepository();

    return Container(
      color: colorScheme.primary.withAlpha(15),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            t.work_with_me,
            style: TextStyle(
              fontSize: isSmallScreen ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            t.portfolio_desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withAlpha(179),
            ),
          ),
          const SizedBox(height: 40),
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: _ContactRow(
                        icon: Icons.email_outlined,
                        label: t.email,
                        value: repo.getEmail(),
                        colorScheme: colorScheme,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: _ContactRow(
                        icon: Icons.phone_outlined,
                        label: t.phones,
                        value: repo.getPhone(),
                        colorScheme: colorScheme,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ContactRow(
                      icon: Icons.email_outlined,
                      label: t.email,
                      value: repo.getEmail(),
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(width: 60),
                    _ContactRow(
                      icon: Icons.phone_outlined,
                      label: t.phones,
                      value: repo.getPhone(),
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
          const SizedBox(height: 40),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined, size: 18),
              label: Text(t.send_me_an_email),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colorScheme;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withAlpha(153),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
