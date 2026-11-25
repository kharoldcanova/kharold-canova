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
            'Estuve a cargo de mm2, la app con la que los clientes del estudio siguen su caso, dentro de un equipo de 2–3 desarrolladores (App Store y Google Play, unas 115 personas activas). Primero mantuve el código heredado y después la rehice desde cero con Clean Architecture y BLoC.',
            'La nueva versión trajo un diseño más claro y notificaciones push con Firebase, para que los clientes vean el estado de su caso y se enteren cuando llega un documento.',
            'Automaticé la publicación con GitHub Actions (build, firma y subida a las tiendas): lo que antes tomaba un día o más de trabajo manual ahora sale solo, sin necesitar una Mac.',
            'También hice APIs con Laravel, PHP 8.x y MySQL, pantallas con Vue.js y automatizaciones para el equipo de TI con Google Apps Script (inventario en GLPI, alta de usuarios de Google Workspace, reportes automáticos al chat de finanzas con webhooks de Google Chat). Por mi cuenta armé ia-sql para agilizar sus informes.',
          ],
          highlightsEn: const [
            'I owned mm2, the app the firm\'s clients use to follow their case, within a 2–3 person dev team (App Store and Google Play, about 115 active users). First I maintained the inherited code, then I rebuilt it from scratch with Clean Architecture and BLoC.',
            'The new version brought a clearer design and Firebase push notifications, so clients can see their case status and know when a document arrives.',
            'I automated releases with GitHub Actions (build, signing and upload to the stores): what used to take a day or more of manual work now ships by itself, no Mac needed.',
            'I also built APIs with Laravel, PHP 8.x and MySQL, screens with Vue.js, and automations for the IT team with Google Apps Script (GLPI inventory, Google Workspace user setup, automated reports to the finance chat through Google Chat webhooks). On my own initiative I built ia-sql to speed up their reports.',
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
            'Hice dos apps Flutter (clientes y retail) de principio a fin, desde las primeras pantallas hasta las versiones listas para producción. Eran apps internas de la empresa.',
            'Armé un catálogo de widgets que compartían ambas apps; una pantalla nueva pasó de tomar una semana a 2–3 días.',
            'Usé Firebase (Authentication, Realtime Database y Firestore) para el login y los datos en tiempo real.',
          ],
          highlightsEn: const [
            'I built two Flutter apps (customers and retail) end to end, from the first screens to production-ready builds. They were internal company apps.',
            'I put together a widget catalog both apps shared; a new screen went from a week of work to 2–3 days.',
            'I used Firebase (Authentication, Realtime Database and Firestore) for sign-in and real-time data.',
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
              'Nació porque al equipo de TI le pedían muchos informes: escribes la pregunta y te devuelve el SQL. Empezó con la API de OpenAI y lo pasé a modelos locales con Ollama para que saliera más barato; solo lee, nunca modifica datos.',
          descriptionEn:
              'It started because the IT team got a lot of report requests: you type the question and it gives you the SQL. It began on the OpenAI API and I moved it to local Ollama models to make it cheaper; it only reads, never changes data.',
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
              'Un asistente de IA que corre en local con TFLite. Más de 2.500 líneas de Python y 36 tests.',
          descriptionEn:
              'An AI assistant that runs locally with TFLite. Over 2,500 lines of Python and 36 tests.',
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
              'Un asistente que ve y habla, funcionando en un Android real sin internet: MiniCPM-V con llama.cpp para la visión y Kokoro para la voz. Ahora le estoy sumando reconocimiento de voz con Whisper.',
          descriptionEn:
              'An assistant that sees and talks, running on a real Android phone with no internet: MiniCPM-V on llama.cpp for vision and Kokoro for voice. I\'m now adding speech recognition with Whisper.',
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
              'Esta misma página. Flutter Web en español e inglés, con tema claro y oscuro, tests y un despliegue que se hace solo con GitHub Actions.',
          descriptionEn:
              'This very page. Flutter Web in Spanish and English, light and dark themes, tests, and a deploy that runs by itself with GitHub Actions.',
          techStack: ['Flutter Web', 'BLoC', 'GitHub Actions'],
          category: 'Este sitio',
          categoryEn: 'This site',
          liveUrl: 'https://kharoldcanova.github.io',
          icon: Icons.web_outlined,
        ),
        const Project(
          title: 'design-md',
          description:
              'Una skill para diseñar interfaces, con editor visual, verificador de tokens de diseño y servidor local. Open source (Apache-2.0).',
          descriptionEn:
              'A skill for designing interfaces, with a visual editor, a design-token checker and a local server. Open source (Apache-2.0).',
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
              'Mi app de finanzas personales, en Flutter con Clean Architecture y BLoC. Funciona sin conexión gracias a Drift/SQLite y tiene tests y CI. Todavía la estoy construyendo.',
          descriptionEn:
              'My personal finance app, in Flutter with Clean Architecture and BLoC. It works offline thanks to Drift/SQLite and has tests and CI. Still a work in progress.',
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
