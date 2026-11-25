import 'package:flutter/material.dart';
import 'package:kharoldcanova/data/models/certification_group.dart';
import 'package:kharoldcanova/data/models/experience.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/models/published_skill.dart';
import 'package:kharoldcanova/data/models/skill_group.dart';

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
            'Único responsable de mm2, la app Flutter para clientes del estudio, dentro de un equipo de 2–3 desarrolladores (publicada en App Store y Google Play, ~115 usuarios activos): primero mantuve el código heredado y después la reconstruí desde cero con Clean Architecture y BLoC.',
            'Nueva versión con diseño UX renovado y notificaciones push con Firebase: los clientes siguen el estado de su caso, consultan su información legal y reciben avisos de documentos.',
            'Publicación automatizada con GitHub Actions (build, firma y subida a App Store y Google Play): de uno o más días de trabajo manual a un proceso automático, sin depender de una Mac en cada entrega.',
            'APIs RESTful con Laravel, PHP 8.x y MySQL/Eloquent, e interfaces dinámicas con Vue.js.',
            'Automatización de procesos del equipo de TI con Google Apps Script (GLPI, creación de usuarios de Google Workspace, reportes automáticos al chat de finanzas vía webhooks de Google Chat) y ia-sql, creado por iniciativa propia para agilizar sus informes.',
          ],
          highlightsEn: const [
            'Sole owner of mm2, the firm\'s Flutter client app, within a 2–3 person dev team (published on the App Store and Google Play, ~115 active users): first maintained the inherited code, then rebuilt it from scratch with Clean Architecture and BLoC.',
            'The new version brought a redesigned UX and Firebase push notifications: clients track their case status, review their legal information and get document alerts.',
            'Automated releases with GitHub Actions (build, signing and upload to the App Store and Google Play): from a day or more of manual work to an automated run, no Mac needed for every release.',
            'RESTful APIs with Laravel, PHP 8.x and MySQL/Eloquent, plus dynamic interfaces with Vue.js.',
            'Automated IT-team processes with Google Apps Script (GLPI, Google Workspace user creation, automated reports to the finance chat through Google Chat webhooks) and built ia-sql on my own initiative to speed up their reports.',
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
            'Desarrollo de dos apps Flutter (clientes y retail) en todo su ciclo, desde el maquetado de la interfaz hasta builds listos para producción (proyecto interno de la empresa).',
            'Catálogo de widgets reutilizables compartido entre ambas apps: una pantalla nueva pasó de una semana a 2–3 días.',
            'Integración de Firebase Authentication, Realtime Database y Cloud Firestore para accesos seguros y persistencia en tiempo real.',
          ],
          highlightsEn: const [
            'Built two Flutter apps (customers and retail) end to end, from UI layout to production-ready builds (internal company project).',
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

  /// "Competencias clave", in the CV's order and wording.
  List<SkillGroup> getSkillGroups() => const [
        SkillGroup(
          id: 'mobile',
          technologies: [
            'Dart',
            'Clean Architecture',
            'BLoC',
            'Provider',
            'Riverpod (básico)',
            'GoRouter',
            'Drift (SQLite, offline-first)',
            'Push con Firebase',
            'App Store y Google Play',
          ],
          technologiesEn: [
            'Dart',
            'Clean Architecture',
            'BLoC',
            'Provider',
            'Riverpod (basic)',
            'GoRouter',
            'Drift (SQLite, offline-first)',
            'Firebase push notifications',
            'App Store and Google Play',
          ],
        ),
        SkillGroup(
          id: 'ai',
          technologies: [
            'Python',
            'RAG con LlamaIndex',
            'Ollama (LLMs locales)',
            'Agentes de IA',
            'MCP',
            'n8n',
            'Google Apps Script',
            'OpenCode · Claude Code · Codex',
          ],
          technologiesEn: [
            'Python',
            'RAG with LlamaIndex',
            'Ollama (local LLMs)',
            'AI agents',
            'MCP',
            'n8n',
            'Google Apps Script',
            'OpenCode · Claude Code · Codex',
          ],
        ),
        SkillGroup(
          id: 'backend',
          technologies: [
            'Laravel 10',
            'PHP 8.x',
            'Eloquent',
            'FastAPI',
            'APIs RESTful',
            'MySQL',
            'Firebase',
          ],
          technologiesEn: [
            'Laravel 10',
            'PHP 8.x',
            'Eloquent',
            'FastAPI',
            'RESTful APIs',
            'MySQL',
            'Firebase',
          ],
        ),
        SkillGroup(
          id: 'devops',
          technologies: [
            'GitHub Actions',
            'Docker',
            'Docker Compose',
            'Linux (Arch, Ubuntu)',
            'VPS con Nginx/Apache',
            'Bash',
            'Git',
            'Vercel',
          ],
          technologiesEn: [
            'GitHub Actions',
            'Docker',
            'Docker Compose',
            'Linux (Arch, Ubuntu)',
            'VPS with Nginx/Apache',
            'Bash',
            'Git',
            'Vercel',
          ],
        ),
        SkillGroup(
          id: 'frontend',
          technologies: [
            'Vue.js',
            'React',
            'Vite',
            'TypeScript',
            'Tailwind CSS',
          ],
        ),
      ];

  String getEmail() => 'kharoldcanova@gmail.com';

  String getPhone() => '+51 962 268 628';

  String getGithub() => 'https://github.com/kharoldcanova';

  String getLinkedin() => 'https://linkedin.com/in/kharoldcanova';

  /// CV served from `web/`, matching the site language (Spanish by default).
  String getCvUrl([String languageCode = 'es']) => languageCode == 'en'
      ? 'cv-kharold-canova-en.pdf'
      : 'cv-kharold-canova.pdf';

  /// Set this when the owner provides the Medium profile URL.
  String? getMedium() => 'https://medium.com/@kharoldcanova';

  /// Set this when the owner provides the published skill details.
  PublishedSkill? getPublishedSkill() => null;

  /// Projects in the CV's order. mm2 is covered under Experience, as on the CV.
  List<Project> getProjects() => [
        const Project(
          title: 'ia-sql',
          description:
              'RAG de lenguaje natural a SQL (NL2SQL) sobre un esquema real, iniciado con la API de OpenAI y migrado a modelos locales de Ollama para abaratar costos, con guardas de solo lectura. Nació para agilizar los informes que se pedían al equipo de TI.',
          descriptionEn:
              'Natural-language-to-SQL (NL2SQL) RAG over a real schema, started on the OpenAI API and migrated to local Ollama models to cut costs, with read-only safeguards. Built to speed up the report requests the IT team received.',
          techStack: ['RAG', 'NL2SQL', 'SQL', 'Ollama', 'Read-only guard'],
          techStackEn: ['RAG', 'NL2SQL', 'SQL', 'Read-only safeguards'],
          category: 'IA',
          categoryEn: 'AI',
          repoUrl: 'https://github.com/kharoldcanova/ia-sql',
          impact:
              'Corregir una consulta generada es más rápido que escribirla desde cero.',
          impactEn:
              'Correcting a generated query beats writing it from scratch.',
          icon: Icons.storage_outlined,
        ),
        const Project(
          title: 'Alma',
          description:
              'Asistente de IA local con TFLite: más de 2.500 líneas de Python y 36 tests automatizados.',
          descriptionEn:
              'Local AI assistant with TFLite: 2,500+ lines of Python and 36 automated tests.',
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
              'Asistente de IA local multimodal que funciona en un Android real, 100% offline, con modelos descargados de Hugging Face: MiniCPM-V (modelo multimodal ligero) ejecutado con llama.cpp y Kokoro para texto a voz. El reconocimiento de voz con Whisper está en desarrollo.',
          descriptionEn:
              'Local multimodal AI assistant running on a real Android device, fully offline, with models downloaded from Hugging Face: MiniCPM-V (a lightweight multimodal model) run with llama.cpp, and Kokoro for text-to-speech. Speech recognition with Whisper is in progress.',
          techStack: [
            'Flutter',
            'llama.cpp',
            'MiniCPM-V',
            'Kokoro',
            'Whisper',
            'Hugging Face',
            'Offline'
          ],
          techStackEn: [
            'Flutter',
            'llama.cpp',
            'MiniCPM-V',
            'Kokoro',
            'Whisper',
            'Hugging Face',
            'Offline'
          ],
          category: 'IA',
          categoryEn: 'AI',
          repoUrl: 'https://github.com/kharoldcanova/lain',
          impact: 'Visión y voz en el dispositivo: ~3 GB de RAM, cero nube.',
          impactEn: 'Vision and speech on-device: ~3 GB of RAM, zero cloud.',
          icon: Icons.devices_outlined,
        ),
        const Project(
          title: 'kharold-canova',
          description:
              'Portafolio personal en Flutter Web, en español e inglés, con tema claro y oscuro, descarga del CV según el idioma, tests de widgets y despliegue automatizado con GitHub Actions.',
          descriptionEn:
              'Personal portfolio built with Flutter Web, with English and Spanish versions, light and dark themes, a CV download that follows the site language, widget tests, and automated deployment with GitHub Actions.',
          techStack: ['Flutter Web', 'BLoC', 'GitHub Actions'],
          category: 'Este sitio',
          categoryEn: 'This site',
          liveUrl: 'https://kharoldcanova.github.io',
          icon: Icons.web_outlined,
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
          title: 'Kipu',
          description:
              'App de finanzas personales en Flutter con Clean Architecture, BLoC, Drift/SQLite offline-first, tests automatizados y CI (en desarrollo).',
          descriptionEn:
              'Personal finance app in Flutter with Clean Architecture, BLoC, offline-first Drift/SQLite, automated tests and CI (in progress).',
          techStack: ['Flutter', 'BLoC', 'Drift', 'SQLite', 'Offline-first'],
          techStackEn: ['Flutter', 'BLoC', 'Drift', 'SQLite', 'Offline-first'],
          category: 'Proyecto interno',
          categoryEn: 'Internal project',
          icon: Icons.account_balance_wallet_outlined,
        ),
      ];

  /// Certifications grouped and worded as in the CV.
  List<CertificationGroup> getCertificationGroups() => const [
        CertificationGroup(
          id: 'genai',
          meta: 'Google · 2026',
          items: [
            'Introduction to Generative AI',
            'Gen AI: Navigate the Landscape',
            'Gen AI: Unlock Foundational Concepts',
            'Gen AI: Beyond the Chatbot',
          ],
        ),
        CertificationGroup(
          id: 'ai',
          items: [
            'Anthropic · AI Fluency Framework & Foundations (2026)',
            'BIG School · Desarrollo con IA: Programa con Agentes (2026)',
            'Platzi · Automatizaciones con n8n (2025)',
          ],
          itemsEn: [
            'Anthropic · AI Fluency Framework & Foundations (2026)',
            'BIG School · AI Development: Agent Program (2026)',
            'Platzi · n8n Automation (2025)',
          ],
        ),
        CertificationGroup(
          id: 'dev',
          meta: '2022',
          items: [
            'Python Essentials 1',
            'JavaScript Fundamentals',
            'Diseño Web con HTML5 y CSS, Conecta Empleo',
          ],
          itemsEn: [
            'Python Essentials 1',
            'JavaScript Fundamentals',
            'Web Design with HTML5 and CSS, Conecta Empleo',
          ],
        ),
        CertificationGroup(
          id: 'infra',
          meta: 'Cisco Networking Academy · 2022',
          items: [
            'NDG Linux Essentials',
            'Cybersecurity Essentials',
            'Redes empresariales, Seguridad y Automatización',
          ],
          itemsEn: [
            'NDG Linux Essentials',
            'Cybersecurity Essentials',
            'Enterprise Networking, Security and Automation',
          ],
        ),
      ];
}
