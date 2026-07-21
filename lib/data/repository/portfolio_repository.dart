import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/models/experience.dart';
import 'package:kharoldcanova/data/models/skill.dart';
import 'package:kharoldcanova/data/models/project.dart';

class PortfolioRepository {
  List<Experience> getExperiences() => [
        Experience(
          company: 'Mil Mujeres Legal Services',
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
        Skill(name: 'Flutter / Dart', category: 'Mobile', level: 0.95),
        Skill(name: 'Laravel / PHP', category: 'Backend', level: 0.90),
        Skill(name: 'MySQL / SQL', category: 'Backend', level: 0.85),
        Skill(name: 'Git / GitHub Actions', category: 'DevOps', level: 0.85),
        Skill(name: 'Linux / Docker', category: 'DevOps', level: 0.80),
        Skill(name: 'Python / FastAPI', category: 'Backend', level: 0.70),
        Skill(name: 'Vue.js / JavaScript', category: 'Frontend', level: 0.70),
      ];

  int getTotalRepos() => 30;

  String getEmail() => 'kharoldcanova@gmail.com';

  String getPhone() => '+51 987 654 321';

  String getGithub() => 'https://github.com/kharoldcanova';

  String getLinkedin() => 'https://linkedin.com/in/kharoldcanova';

  List<Project> getProjects() => [
        Project(
          title: 'Telegram + Ollama Bot',
          description:
              'Bot de Telegram que conecta n8n con modelos locales de Ollama para automatización de respuestas con IA local.',
          techStack: ['n8n', 'Ollama', 'Docker'],
          category: 'IA',
          repoUrl: 'https://github.com/kharoldcanova/telegram-ollama-bot',
          icon: Icons.smart_toy_outlined,
        ),
        Project(
          title: 'backup-glpi-drive',
          description:
              'Script en Bash para respaldo automatizado y programado de bases de datos MySQL en Google Drive.',
          techStack: ['Bash', 'MySQL', 'crontab'],
          category: 'DevOps',
          repoUrl: 'https://github.com/kharoldcanova/backup-glpi-drive',
          icon: Icons.backup_outlined,
        ),
        Project(
          title: 'Login con Flutter',
          description:
              'Aplicación de inicio de sesión con diseño atractivo que permite autenticarse con Firebase.',
          techStack: ['Flutter', 'Firebase'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/login_flutter',
          icon: Icons.login_outlined,
        ),
        Project(
          title: 'Yes / No Chatbot',
          description:
              'Chatbot que consume una API de respuestas con imágenes Yes/No para interactuar con el usuario.',
          techStack: ['Flutter', 'REST API'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/yes_no_app',
          icon: Icons.help_outline,
        ),
        Project(
          title: 'TokTik Clone',
          description:
              'Clone de TikTok desarrollado con Flutter para visualizar videos cortos con interfaz similar a la original.',
          techStack: ['Flutter'],
          category: 'Mobile',
          repoUrl: 'https://github.com/kharoldcanova/toktik_app_flutter',
          icon: Icons.videocam_outlined,
        ),
      ];
}
