import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/models/experience.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/models/published_skill.dart';
import 'package:kharoldcanova/data/models/skill_group.dart';
import 'package:kharoldcanova/screens/widgets/certifications_section.dart';

class PortfolioRepository {
  List<Experience> getExperiences() => [
        Experience(
          company: 'Mil Mujeres Legal Services',
          role: 'Desarrollador Full Stack',
          roleEn: 'Full Stack Developer',
          location: 'EE.UU. (remoto desde Perú)',
          locationEn: 'USA (remote from Peru)',
          startDate: DateTime(2023, 9, 1),
          endDate: DateTime(2026, 9, 1),
          highlights: const [
            'Único responsable de mm2, la app Flutter para clientes del estudio (iOS, Android y Web, ~115 usuarios activos): primero mantuve el código heredado y después la reconstruí desde cero con Clean Architecture y BLoC.',
            'Nueva versión con diseño UX renovado y notificaciones push con Firebase: los clientes siguen el estado de su caso, consultan su información legal y reciben avisos de documentos.',
            'Publicación automatizada con GitHub Actions (build, firma y subida a App Store y Google Play): de uno o más días de trabajo manual a un proceso automático, sin depender de una Mac en cada entrega.',
            'APIs RESTful con Laravel, PHP 8.x y MySQL/Eloquent, e interfaces dinámicas con Vue.js.',
            'Automatización de procesos del equipo de TI con Google Apps Script (GLPI, creación de usuarios de Google Workspace) y ia-sql, creado por iniciativa propia para agilizar sus informes.',
          ],
          highlightsEn: const [
            'Sole owner of mm2, the firm\'s Flutter client app (iOS, Android and Web, ~115 active users): first maintained the inherited code, then rebuilt it from scratch with Clean Architecture and BLoC.',
            'The new version brought a redesigned UX and Firebase push notifications: clients track their case status, review their legal information and get document alerts.',
            'Automated releases with GitHub Actions (build, signing and upload to the App Store and Google Play): from a day or more of manual work to an automated run, no Mac needed for every release.',
            'RESTful APIs with Laravel, PHP 8.x and MySQL/Eloquent, plus dynamic interfaces with Vue.js.',
            'Automated IT-team processes with Google Apps Script (GLPI, Google Workspace user creation) and built ia-sql on my own initiative to speed up their reports.',
          ],
        ),
        Experience(
          company: 'TECLEAR S.A.C.',
          role: 'Desarrollador Full Stack',
          roleEn: 'Full Stack Developer',
          location: 'Piura, Perú',
          locationEn: 'Piura, Peru',
          startDate: DateTime(2022, 9, 1),
          endDate: DateTime(2023, 7, 31),
          highlights: const [
            'Desarrollo de dos apps Flutter (clientes y retail) en todo su ciclo, desde el maquetado de la interfaz hasta la publicación en tiendas.',
            'Catálogo de widgets reutilizables compartido entre ambas apps: una pantalla nueva pasó de una semana a 2–3 días.',
            'Integración de Firebase Authentication, Realtime Database y Cloud Firestore para accesos seguros y persistencia en tiempo real.',
          ],
          highlightsEn: const [
            'Built two Flutter apps (customers and retail) end to end, from UI layout to app-store release.',
            'Reusable widget catalog shared by both apps: a new screen went from a week to 2–3 days.',
            'Integrated Firebase Authentication, Realtime Database and Cloud Firestore for secure access and real-time persistence.',
          ],
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

  List<SkillGroup> getSkillGroups() => const [
        SkillGroup(
          id: 'ai',
          technologies: [
            'Ollama',
            'RAG',
            'LlamaIndex',
            'Python',
            'FastAPI',
            'MCP',
            'n8n',
          ],
        ),
        SkillGroup(
          id: 'devops',
          technologies: [
            'Docker',
            'Docker Compose',
            'GitHub Actions',
            'Linux',
            'VPS',
            'Nginx',
            'Bash',
            'Git',
            'CI/CD',
          ],
        ),
        SkillGroup(
          id: 'frontend',
          technologies: [
            'Flutter',
            'Clean Architecture',
            'BLoC',
            'Riverpod',
            'GoRouter',
            'Drift',
            'SQLite',
            'TypeScript',
            'React',
            'Vue.js',
            'Tailwind CSS',
          ],
        ),
        SkillGroup(
          id: 'backend',
          technologies: [
            'Laravel 10',
            'PHP 8.x',
            'REST APIs',
            'MySQL',
            'Firebase',
            'Authentication',
            'Cloud Firestore',
            'FCM',
          ],
        ),
      ];

  int getTotalRepos() => 30;

  String getEmail() => 'kharoldcanova@gmail.com';

  String getPhone() => '+51 962 268 628';

  String getGithub() => 'https://github.com/kharoldcanova';

  String getLinkedin() => 'https://linkedin.com/in/kharoldcanova';

  String getCvUrl() => 'cv-kharold-canova.pdf';

  /// Set this when the owner provides the Medium profile URL.
  String? getMedium() => 'https://medium.com/@kharoldcanova';

  /// Set this when the owner provides the published skill details.
  PublishedSkill? getPublishedSkill() => null;

  /// Curated order for the Applied AI section. These projects lead the
  /// portfolio regardless of how the full project list is sorted.
  static const featuredAiTitles = <String>['ia-sql', 'Alma', 'LAIN'];

  List<Project> getFeaturedAiProjects() {
    final projects = getProjects();
    return [
      for (final title in featuredAiTitles)
        ...projects.where((project) => project.title == title),
    ];
  }

  List<Project> getProjects() => [
        const Project(
          title: 'ia-sql',
          description:
              'RAG de lenguaje natural a SQL (NL2SQL) con modelos de Ollama sobre un esquema real, con guardas de solo lectura. Nació para agilizar los informes que se pedían al equipo de TI.',
          descriptionEn:
              'Natural-language-to-SQL (NL2SQL) RAG with Ollama models over a real schema, with read-only safeguards. Built to speed up the report requests the IT team received.',
          techStack: ['RAG', 'NL2SQL', 'SQL', 'Read-only guard'],
          techStackEn: ['RAG', 'NL2SQL', 'SQL', 'Read-only safeguards'],
          category: 'IA',
          categoryEn: 'AI',
          repoUrl: 'https://github.com/kharoldcanova/ia-sql',
          impact: 'Corregir una consulta generada es más rápido que escribirla desde cero.',
          impactEn:
              'Correcting a generated query beats writing it from scratch.',
          icon: Icons.storage_outlined,
        ),
        const Project(
          title: 'Alma',
          description:
              'Asistente de IA local desarrollado en Python, con más de 2.5k líneas y 36 pruebas automatizadas.',
          descriptionEn:
              'Local AI assistant built in Python, with over 2.5k lines of code and 36 automated tests.',
          techStack: ['Python', 'IA local', 'TFLite', '36 tests'],
          techStackEn: ['Python', 'Local AI', 'TFLite', '36 tests'],
          category: 'IA',
          categoryEn: 'AI',
          repoUrl: 'https://github.com/kharoldcanova/alma',
          impact: '2.5k+ líneas · 36 pruebas automatizadas · 100% local.',
          impactEn: '2.5k+ lines · 36 automated tests · 100% local.',
          icon: Icons.psychology_outlined,
        ),
        const Project(
          title: 'LAIN',
          description:
              'Asistente de IA local multimodal para Android: Whisper (STT) → MiniCPM-V (LLM) → Kokoro (TTS) sobre llama.cpp, 100% offline con consciencia funcional y fine-tuning QLoRA/Unsloth.',
          descriptionEn:
              'Local multimodal AI assistant for Android: Whisper (STT) → MiniCPM-V (LLM) → Kokoro (TTS) on llama.cpp, fully offline with functional consciousness and QLoRA/Unsloth fine-tuning.',
          techStack: ['Flutter', 'llama.cpp', 'MiniCPM-V', 'Whisper', 'Kokoro', 'QLoRA', 'Python', 'Offline'],
          techStackEn: ['Flutter', 'llama.cpp', 'MiniCPM-V', 'Whisper', 'Kokoro', 'QLoRA', 'Python', 'Offline'],
          category: 'IA',
          categoryEn: 'AI',
          repoUrl: 'https://github.com/kharoldcanova/lain',
          impact: 'Voz y visión en el dispositivo: ~3 GB de RAM, cero nube.',
          impactEn: 'Voice and vision on-device: ~3 GB of RAM, zero cloud.',
          icon: Icons.devices_outlined,
        ),
        const Project(
          title: 'design-md',
          description:
              'Skill publicada para diseño de interfaces: editor visual, verificación de tokens de diseño y servidor local.',
          descriptionEn:
              'Published interface-design skill with a visual editor, design-token validation, and a local server.',
          techStack: ['Design systems', 'Editor visual', 'Apache-2.0'],
          techStackEn: ['Design systems', 'Visual editor', 'Apache-2.0'],
          category: 'Open source',
          categoryEn: 'Open source',
          repoUrl: 'https://github.com/kharoldcanova/design-md',
          icon: Icons.design_services_outlined,
        ),
        const Project(
          title: 'mm2',
          description:
              'App Flutter para clientes de servicios legales, reconstruida desde cero con Clean Architecture y BLoC: diseño UX renovado, notificaciones push con Firebase, API Laravel y publicación automatizada en App Store y Google Play.',
          descriptionEn:
              'Flutter app for legal-services clients, rebuilt from scratch with Clean Architecture and BLoC: redesigned UX, Firebase push notifications, a Laravel API and automated App Store and Google Play releases.',
          techStack: ['Flutter', 'BLoC', 'Laravel API', 'GitHub Actions'],
          techStackEn: ['Flutter', 'BLoC', 'Laravel API', 'GitHub Actions'],
          category: 'Proyecto interno',
          categoryEn: 'Internal project',
          impact: '~115 usuarios activos · único desarrollador responsable.',
          impactEn: '~115 active users · sole developer.',
          icon: Icons.gavel_outlined,
        ),
        const Project(
          title: 'Kipu',
          description:
              'Wallet personal para finanzas con Flutter, Clean Architecture, BLoC y almacenamiento offline-first con Drift y SQLite.',
          descriptionEn:
              'Personal finance wallet built with Flutter, Clean Architecture, BLoC, and offline-first storage using Drift and SQLite.',
          techStack: ['Flutter', 'BLoC', 'Drift', 'SQLite', 'Offline-first'],
          techStackEn: ['Flutter', 'BLoC', 'Drift', 'SQLite', 'Offline-first'],
          category: 'Proyecto interno',
          categoryEn: 'Internal project',
          icon: Icons.account_balance_wallet_outlined,
        ),
      ];

  List<CertificationItem> getCertifications() => const [
        CertificationItem(
          title: 'Google',
          subtitle: 'Gen AI: Navigate the Landscape',
          subtitleEn: 'Gen AI: Navigate the Landscape',
          date: 'Julio 2026',
          dateEn: 'July 2026',
          icon: Icons.travel_explore,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Gen AI: Unlock Foundational Concepts',
          subtitleEn: 'Gen AI: Unlock Foundational Concepts',
          date: 'Julio 2026',
          dateEn: 'July 2026',
          icon: Icons.lightbulb,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Gen AI: Beyond the Chatbot',
          subtitleEn: 'Gen AI: Beyond the Chatbot',
          date: 'Julio 2026',
          dateEn: 'July 2026',
          icon: Icons.smart_toy,
        ),
        CertificationItem(
          title: 'Google',
          subtitle: 'Introduction to Generative AI',
          subtitleEn: 'Introduction to Generative AI',
          date: 'Julio 2026',
          dateEn: 'July 2026',
          icon: Icons.auto_awesome,
        ),
        CertificationItem(
          title: 'Anthropic',
          subtitle: 'AI Fluency Framework & Foundations',
          subtitleEn: 'AI Fluency Framework & Foundations',
          date: 'Julio 2026',
          dateEn: 'July 2026',
          icon: Icons.psychology,
        ),
        CertificationItem(
          title: 'BIG School',
          subtitle: 'Desarrollo con IA: Programa con Agentes',
          subtitleEn: 'AI-driven development: Agent Program',
          date: 'Junio 2026',
          dateEn: 'June 2026',
          icon: Icons.hub,
        ),
        CertificationItem(
          title: 'Platzi',
          subtitle: 'Curso de Automatizaciones con n8n',
          subtitleEn: 'n8n Automation Course',
          date: 'Diciembre 2025',
          dateEn: 'December 2025',
          icon: Icons.bolt,
        ),
        CertificationItem(
          title: 'Cisco Networking Academy',
          subtitle: 'NDG Linux Essentials',
          subtitleEn: 'NDG Linux Essentials',
          date: 'Abril 2022',
          dateEn: 'April 2022',
          icon: Icons.terminal,
        ),
        CertificationItem(
          title: 'Cisco Networking Academy',
          subtitle: 'Cybersecurity Essentials',
          subtitleEn: 'Cybersecurity Essentials',
          date: 'Marzo 2022',
          dateEn: 'March 2022',
          icon: Icons.security,
        ),
        CertificationItem(
          title: 'EF SET',
          subtitle: 'EF SET English Certificate (B1 Intermediate - 42/100)',
          subtitleEn: 'EF SET English Certificate (B1 Intermediate - 42/100)',
          date: 'Febrero 2023',
          dateEn: 'February 2023',
          icon: Icons.translate,
        ),
      ];
}
