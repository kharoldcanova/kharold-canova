import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WhatICanDoWidget extends StatelessWidget {
  const WhatICanDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      color: color.primary,
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '¿Qué es lo que puedo hacer?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: color.onPrimary,
              ),
            ),
            const SizedBox(height: 60),
            const Wrap(
              spacing: 15,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                SkillItem(
                  icon: Icons.code_outlined,
                  title: 'Páginas Web',
                  description:
                      'Desarrollo de páginas web con HTML, CSS y JavaScript. También puedo usar frameworks como Flutter Web.',
                ),
                SkillItem(
                  icon: Icons.phone_android,
                  title: 'Aplicaciones móviles',
                  description:
                      'Desarrollo de aplicaciones móviles con el framework Flutter para Android e iOS.',
                ),
                SkillItem(
                  icon: Icons.storage_outlined,
                  title: 'Bases de datos',
                  description: 'Manejo de bases de datos SQL como MySQL.',
                ),
                SkillItem(
                  icon: Icons.cloud_outlined,
                  title: 'Automatización con GitHub Actions',
                  description:
                      'Implementación de flujos de trabajo automatizados utilizando GitHub Actions para CI/CD.',
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
