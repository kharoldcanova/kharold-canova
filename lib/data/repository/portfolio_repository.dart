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
          title: 'Alma',
          description:
              'Asistente de voz con IA 100% local: escucha la wake word "hey jarvis" con openWakeWord, transcribe con faster-whisper, responde con Ollama y habla con Piper.',
          techStack: ['Python', 'Ollama', 'openWakeWord'],
          category: 'IA',
          repoUrl: 'https://github.com/kharoldcanova/alma',
          icon: Icons.mic_outlined,
        ),
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
          title: 'Google',
          subtitle: 'Gen AI: Navigate the Landscape',
          date: 'Julio 2026',
          color: Colors.blue,
          icon: Icons.travel_explore,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Gen AI: Unlock Foundational Concepts',
          date: 'Julio 2026',
          color: Colors.blueAccent,
          icon: Icons.lightbulb,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Gen AI: Beyond the Chatbot',
          date: 'Julio 2026',
          color: Colors.indigo,
          icon: Icons.smart_toy,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Introduction to Generative AI',
          date: 'Julio 2026',
          color: Colors.blueGrey,
          icon: Icons.auto_awesome,
        ),
        CertificationItem(
          title: 'Anthropic',
          subtitle: 'AI Fluency Framework & Foundations',
          date: 'Julio 2026',
          color: Colors.deepOrange,
          icon: Icons.psychology,
        ),
        CertificationItem(
          title: 'BIG School',
          subtitle: 'Desarrollo con IA: Programa con Agentes',
          date: 'Junio 2026',
          color: Colors.teal,
          icon: Icons.hub,
        ),
        CertificationItem(
          title: 'Platzi',
          subtitle: 'Curso de Automatizaciones con n8n',
          date: 'Diciembre 2025',
          color: Colors.green,
          icon: Icons.bolt,
        ),
        CertificationItem(
          title: 'Hacker Mentor',
          subtitle: 'Curso Ethical Hacking / Red Team (3ra edición)',
          date: 'Marzo 2023',
          color: Colors.purple,
          icon: Icons.security,
        ),
        CertificationItem(
          title: 'Hacker Mentor',
          subtitle: 'Curso Hacking Wi-Fi',
          date: 'Abril 2022',
          color: Colors.indigo,
          icon: Icons.wifi_lock,
        ),
        CertificationItem(
          title: 'INCIBE',
          subtitle: 'Protege tu Negocio: Ciberseguridad en el Teletrabajo',
          date: 'Marzo 2023',
          color: Colors.cyan,
          icon: Icons.shield,
        ),
        CertificationItem(
          title: 'Escalab',
          subtitle: 'JavaScript Fundamentals',
          date: 'Mayo 2022',
          color: Colors.amber,
          icon: Icons.javascript,
        ),
        CertificationItem(
          title: 'EF SET',
          subtitle: 'EF SET English Certificate (B1 Intermediate - 42/100)',
          date: 'Febrero 2023',
          color: Colors.redAccent,
          icon: Icons.translate,
        ),
        CertificationItem(
          title: 'Cisco Networking Academy',
          subtitle: 'Ciberseguridad y Redes Informáticas',
          date: 'Julio 2023',
          color: Colors.deepPurple,
          icon: Icons.router,
        ),
      ];
}
