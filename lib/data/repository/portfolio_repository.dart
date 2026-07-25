import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/models/experience.dart';
import 'package:kharoldcanova/data/models/skill.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/screens/widgets/certifications_section.dart';

class PortfolioRepository {
  List<Experience> getExperiences() => [
        Experience(
          company: 'ONG Mil Mujeres Legal Services EE.UU',
          role: 'Desarrollador Full Stack',
          startDate: DateTime(2023, 9, 1),
          endDate: null,
        ),
        Experience(
          company: 'TECLEAR S.A.C.',
          role: 'Desarrollador Full Stack',
          startDate: DateTime(2022, 9, 1),
          endDate: DateTime(2022, 12, 1),
        ),
        Experience(
          company: 'Centro de Empleo Sullana',
          role: 'Administrador / Community Manager',
          startDate: DateTime(2022, 5, 1),
          endDate: DateTime(2022, 6, 1),
        ),
      ];

  double getTotalYearsExperience() {
    final experiences = getExperiences();
    double total = 0;
    for (final exp in experiences) {
      total += exp.years;
    }
    return total;
  }

  List<Skill> getSkills() => [
        const Skill(name: 'Flutter / Dart', category: 'Mobile', level: 0.95),
        const Skill(name: 'Laravel / PHP', category: 'Backend', level: 0.90),
        const Skill(name: 'MySQL / SQL', category: 'Backend', level: 0.85),
        const Skill(
            name: 'Git / GitHub Actions', category: 'DevOps', level: 0.85),
        const Skill(name: 'Linux / Docker', category: 'DevOps', level: 0.80),
        const Skill(name: 'Python / FastAPI', category: 'Backend', level: 0.70),
        const Skill(
            name: 'Vue.js / JavaScript', category: 'Frontend', level: 0.70),
      ];

  int getTotalRepos() => 30;

  String getEmail() => 'kharoldcanova@gmail.com';

  String getPhone() => '+51 962 268 628';

  String getGithub() => 'https://github.com/kharoldcanova';

  String getLinkedin() => 'https://linkedin.com/in/kharoldcanova';

  List<Project> getProjects() => [
        const Project(
          title: 'Telegram + Ollama Bot',
          description:
              'Bot de Telegram que conecta n8n con modelos locales de Ollama para automatización de respuestas con IA local.',
          techStack: ['n8n', 'Ollama', 'Docker'],
          category: 'IA',
          repoUrl: 'https://github.com/kharoldcanova/telegram-ollama-bot',
          icon: Icons.smart_toy_outlined,
        ),
        const Project(
          title: 'backup-glpi-drive',
          description:
              'Script en Bash para respaldo automatizado y programado de bases de datos MySQL en Google Drive.',
          techStack: ['Bash', 'MySQL', 'crontab'],
          category: 'DevOps',
          repoUrl: 'https://github.com/kharoldcanova/backup-glpi-drive',
          icon: Icons.backup_outlined,
        ),
        const Project(
          title: 'Login con Flutter',
          description:
              'Aplicación de inicio de sesión con diseño atractivo que permite autenticarse con Firebase.',
          techStack: ['Flutter', 'Firebase'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/login_flutter',
          icon: Icons.login_outlined,
        ),
        const Project(
          title: 'Yes / No Chatbot',
          description:
              'Chatbot que consume una API de respuestas con imágenes Yes/No para interactuar con el usuario.',
          techStack: ['Flutter', 'REST API'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/yes_no_app',
          icon: Icons.help_outline,
        ),
        const Project(
          title: 'TokTik Clone',
          description:
              'Clone de TikTok desarrollado con Flutter para visualizar videos cortos con interfaz similar a la original.',
          techStack: ['Flutter'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/toktik_app_flutter',
          icon: Icons.videocam_outlined,
        ),
      ];

  List<CertificationItem> getCertifications() => const [
        CertificationItem(
          title: 'BIG School',
          subtitle: 'Desarrollo con IA: Programa con Agentes',
          date: 'Julio 2026',
          color: Colors.blue,
          icon: Icons.psychology,
        ),
        CertificationItem(
          title: 'Cisco Networking Academy',
          subtitle: 'Ciberseguridad y Redes Informáticas',
          date: '2025',
          color: Colors.purple,
          icon: Icons.shield,
        ),
        CertificationItem(
          title: 'Platzi',
          subtitle: 'Programación Básica y Videojuegos',
          date: '2025',
          color: Colors.green,
          icon: Icons.code,
        ),
        CertificationItem(
          title: 'Escalab Academy',
          subtitle: 'Fundamentos de JavaScript',
          date: '2024',
          color: Colors.amber,
          icon: Icons.javascript,
        ),
        CertificationItem(
          title: 'Conecta Empleo',
          subtitle: 'Diseño Web con HTML y CSS',
          date: '2024',
          color: Colors.deepOrange,
          icon: Icons.web,
        ),
        CertificationItem(
          title: 'Hacker Mentor',
          subtitle: 'Hacking Ético Wi-Fi',
          date: '2024',
          color: Colors.indigo,
          icon: Icons.wifi_lock,
        ),
      ];
}
