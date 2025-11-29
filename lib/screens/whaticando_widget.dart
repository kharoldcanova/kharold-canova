import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class WhatICanDoWidget extends StatelessWidget {
  const WhatICanDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final translations = AppLocalizations.of(context)!;

    return Container(
      color: color.primary,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              translations.what_i_can_do_title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: color.onPrimary,
              ),
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 15,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                SkillItem(
                  icon: Icons.code_outlined,
                  title: translations.web_pages,
                  description: translations.web_pages_description,
                ),
                SkillItem(
                  icon: Icons.phone_android,
                  title: translations.mobile_apps,
                  description: translations.mobile_apps_description,
                ),
                SkillItem(
                  icon: Icons.storage_outlined,
                  title: translations.database_management,
                  description: translations.database_management_description,
                ),
                SkillItem(
                  icon: Icons.cloud_outlined,
                  title: translations.automatizaacion_gitactions,
                  description:
                      translations.automatizaacion_gitactions_description,
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SkillItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: color.onPrimary,
            child: Icon(
              icon,
              color: color.primary,
              size: 100,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: color.onPrimary,
              ),
            ),
            subtitle: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: color.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
