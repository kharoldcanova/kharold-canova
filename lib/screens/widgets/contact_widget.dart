import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;
    final repo = PortfolioRepository();

    return Container(
      width: double.infinity,
      color: colorScheme.primary.withAlpha(15),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 24 : 40,
            ),
            child: Column(
              children: [
                Text(
                  t.work_with_me,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 28 : 36,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Text(
                    t.portfolio_desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      color: colorScheme.onSurface.withAlpha(180),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                if (isSmallScreen)
                  Column(
                    children: [
                      _ContactCard(
                        icon: Icons.email_outlined,
                        label: t.email,
                        value: repo.getEmail(),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 20),
                      _ContactCard(
                        icon: Icons.phone_outlined,
                        label: t.phones,
                        value: repo.getPhone(),
                        colorScheme: colorScheme,
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ContactCard(
                        icon: Icons.email_outlined,
                        label: t.email,
                        value: repo.getEmail(),
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(width: 32),
                      _ContactCard(
                        icon: Icons.phone_outlined,
                        label: t.phones,
                        value: repo.getPhone(),
                        colorScheme: colorScheme,
                      ),
                    ],
                  ),
                const SizedBox(height: 56),
                FilledButton.icon(
                  onPressed: () {
                    launchUrl(
                      Uri.parse('https://mail.google.com/mail/?view=cm&fs=1&to=kharoldcanova@gmail.com'),
                    );
                  },
                  icon: const Icon(Icons.send_outlined),
                  label: Text(t.send_me_an_email),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(240, 52),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colorScheme;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withAlpha(40),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
                const SizedBox(height: 6),
                SelectableText(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
