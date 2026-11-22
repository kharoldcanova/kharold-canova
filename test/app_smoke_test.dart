import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/config/theme/theme_preferences.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/screens/widgets/about_skills_widget.dart';
import 'package:kharoldcanova/screens/widgets/ai_systems_widget.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/experience_timeline.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:kharoldcanova/screens/widgets/skill_groups_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('the repository points at the new AI & DevOps CV', () {
    expect(
      PortfolioRepository().getCvUrl(),
      'cv-kharold-canova.pdf',
    );
  });

  test('experience data matches the CV (active users, TECLEAR dates)', () {
    final experiences = PortfolioRepository().getExperiences();
    final milMujeres = experiences.first;
    expect(milMujeres.highlights.join(' '), contains('115 usuarios activos'));
    expect(milMujeres.highlightsEn!.join(' '), contains('115 active users'));
    expect(milMujeres.highlights.join(' '), isNot(contains('miles')));
    final teclear = experiences[1];
    expect(teclear.startDate, DateTime(2022, 9, 1));
    expect(teclear.endDate, DateTime(2023, 7, 31));
  });

  test('LAIN only claims what is built (no fine-tuning, no consciousness)', () {
    final lain = PortfolioRepository()
        .getProjects()
        .firstWhere((project) => project.title == 'LAIN');
    for (final text in <String>[lain.description, lain.descriptionEn!]) {
      expect(text, isNot(contains('QLoRA')));
      expect(text.toLowerCase(), isNot(contains('consc')));
    }
    expect(lain.techStack, isNot(contains('QLoRA')));
    expect(lain.description, contains('Hugging Face'));
  });

  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
  }

  Finder headerText(String text) {
    return find.descendant(
      of: find.byType(HeaderWidget),
      matching: find.text(text),
    );
  }

  Color? underlineColor(WidgetTester tester, String label) {
    final link = find.widgetWithText(TextButton, label).first;
    final container = tester.widget<AnimatedContainer>(
      find
          .descendant(
            of: link,
            matching: find.byType(AnimatedContainer),
          )
          .first,
    );
    final border = (container.decoration! as BoxDecoration).border! as Border;
    return border.bottom.color;
  }

  BoxDecoration headerDecoration(WidgetTester tester) {
    final container = tester.widget<AnimatedContainer>(
      find
          .descendant(
            of: find.byType(HeaderWidget),
            matching: find.byType(AnimatedContainer),
          )
          .first,
    );
    return container.decoration! as BoxDecoration;
  }

  testWidgets(
      'first visit is light and renders the image hero without a portrait',
      (tester) async {
    await pumpApp(tester);

    final scaffold = tester.element(find.byType(Scaffold));
    expect(Theme.of(scaffold).brightness, Brightness.light);
    expect(find.text('Kharold Canova'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNothing);
    expect(find.text('Descargar CV'), findsOneWidget);
  });

  testWidgets('AI section is the first content block and precedes about',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    final aiTop = tester.getTopLeft(find.byType(AISystemsWidget)).dy;
    final aboutTop = tester.getTopLeft(find.byType(AboutSkillsWidget)).dy;
    expect(aiTop, lessThan(aboutTop));

    for (final project in <String>['ia-sql', 'Alma', 'LAIN']) {
      expect(
        find.descendant(
          of: find.byType(AISystemsWidget),
          matching: find.text(project),
        ),
        findsOneWidget,
        reason: project,
      );
      expect(find.byKey(Key('ai-project-link-$project')), findsOneWidget);
    }
  });

  testWidgets('hero surfaces the applied AI role and key links',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(
      find.text('Desarrollador Full Stack · Flutter · IA aplicada'),
      findsOneWidget,
    );
    expect(find.text('RAG · AGENTES · NL2SQL · MULTIMODAL'), findsOneWidget);
    expect(find.text('Explorar sistemas de IA'), findsOneWidget);

    for (final key in <String>[
      'hero-cv',
      'hero-github-rail',
      'hero-linkedin-rail',
    ]) {
      expect(find.byKey(Key(key)), findsOneWidget, reason: key);
    }
  });

  testWidgets('mobile hero keeps GitHub and LinkedIn reachable',
      (tester) async {
    await pumpApp(tester);

    for (final key in <String>['hero-github', 'hero-linkedin']) {
      expect(find.byKey(Key(key)), findsOneWidget, reason: key);
    }
    expect(find.byKey(const Key('hero-github-rail')), findsNothing);
  });

  testWidgets('compact hero uses ink roles over the light wallpaper sky',
      (tester) async {
    await pumpApp(tester);

    final scaffold = tester.element(find.byType(Scaffold));
    final name = tester.widget<Text>(find.text('Kharold Canova'));
    expect(name.style?.color, Theme.of(scaffold).colorScheme.onSurface);
  });

  testWidgets('desktop hero keeps on-image roles over the mountains',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    final scaffold = tester.element(find.byType(Scaffold));
    final tokens = Theme.of(scaffold).extension<PortfolioTokens>()!;
    final name = tester.widget<Text>(find.text('Kharold Canova'));
    expect(name.style?.color, tokens.onImage);
  });

  testWidgets('hero AI action scrolls to the AI section and marks it active',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(find.byKey(const Key('hero-explore-ai')));
    await tester.pumpAndSettle();

    expect(underlineColor(tester, 'IA'), const Color(0xFF0033CC));
  });

  testWidgets('contact exposes GitHub and LinkedIn next to email and phone',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.byKey(const Key('contact-github')), findsOneWidget);
    expect(find.byKey(const Key('contact-linkedin')), findsOneWidget);
  });

  testWidgets('hero stays shorter than the viewport on mobile and desktop',
      (tester) async {
    await pumpApp(tester, size: const Size(390, 844));

    var hero = tester.getSize(find.byType(HeroWidget));
    expect(hero.width, 390);
    expect(hero.height, closeTo(844 * 0.68, 0.01));
    expect(hero.height, lessThan(844));

    tester.view.physicalSize = const Size(1300, 900);
    await tester.pumpAndSettle();

    hero = tester.getSize(find.byType(HeroWidget));
    expect(hero.width, 1300);
    expect(hero.height, closeTo(900 * 0.72, 0.01));
    expect(hero.height, lessThan(900));
  });

  testWidgets('contact uses the primary blue surface with on-primary text',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    final section = tester.widget<SectionContainer>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.byType(SectionContainer),
      ),
    );
    expect(section.background, const Color(0xFF0033CC));

    final title = tester.widget<Text>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.text('Contacto'),
      ),
    );
    expect(title.style?.color, Colors.white);

    final heading = tester.widget<Text>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.text('¿Te gustaría trabajar conmigo?'),
      ),
    );
    expect(heading.style?.color, Colors.white);

    final description = tester.widget<Text>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.text('Cuéntame sobre tu proyecto o simplemente saluda.'),
      ),
    );
    expect(
      description.style?.color,
      Colors.white.withValues(alpha: 0.82),
    );

    final card = find
        .ancestor(
          of: find.byIcon(Icons.email_outlined),
          matching: find.byType(AnimatedContainer),
        )
        .first;
    final decoration =
        tester.widget<AnimatedContainer>(card).decoration! as BoxDecoration;
    expect(decoration.color, Colors.transparent);
    expect(
      (decoration.border! as Border).top.color,
      Colors.white.withValues(alpha: 0.4),
    );
  });

  testWidgets('dark contact uses a green surface and white text',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('terminal-tab-contact')));
    await tester.pumpAndSettle();

    final section = tester.widget<SectionContainer>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.byType(SectionContainer),
      ),
    );
    expect(section.background, BrandColors.darkContactBackground);

    final title = tester.widget<Text>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.text('Contacto'),
      ),
    );
    expect(title.style?.color, Colors.white);
  });

  testWidgets('about renders the experience timeline and grouped tech stack',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.byType(ExperienceTimeline), findsOneWidget);
    expect(find.text('Experiencia'), findsOneWidget);
    expect(find.text('Mil Mujeres Legal Services'), findsOneWidget);
    expect(find.text('Desarrollador Full Stack'), findsNWidgets(2));
    expect(find.text('TECLEAR S.A.C.'), findsOneWidget);

    expect(find.byType(SkillGroupsGrid), findsOneWidget);
    expect(find.text('Stack técnico'), findsOneWidget);
    for (final technology in <String>[
      'LlamaIndex',
      'GitHub Actions',
      'Clean Architecture',
      'MySQL',
    ]) {
      expect(
        find.descendant(
          of: find.byType(SkillGroupsGrid),
          matching: find.text(technology),
        ),
        findsOneWidget,
        reason: technology,
      );
    }
  });

  testWidgets('theme control opts into dark mode and persists the choice',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();

    final scaffold = tester.element(find.byType(Scaffold));
    expect(Theme.of(scaffold).brightness, Brightness.dark);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(ThemePreferences.storageKey), 'dark');
  });

  testWidgets('desktop navigation exposes six labels and scrolls to projects',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    for (final label in <String>[
      'Inicio',
      'IA',
      'Sobre mí',
      'Proyectos',
      'Certificaciones',
      'Contacto',
    ]) {
      expect(headerText(label), findsOneWidget, reason: label);
    }

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();

    final scrollView = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
    expect(scrollView.controller!.offset, greaterThan(0));

    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();

    expect(headerText('Home'), findsOneWidget);
    expect(headerText('Projects'), findsOneWidget);
    expect(headerText('Certifications'), findsOneWidget);
  });

  testWidgets('theme control tooltip follows the locale and active mode',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.byTooltip('Activar modo oscuro'), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Switch to dark mode'), findsOneWidget);

    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Switch to light mode'), findsOneWidget);
  });

  testWidgets('header moves from transparent to nav surface on scroll',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    var decoration = headerDecoration(tester);
    expect(decoration.color, Colors.transparent);
    expect(
      (decoration.border! as Border).bottom.color,
      Colors.transparent,
    );

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();

    decoration = headerDecoration(tester);
    expect(decoration.color, const Color(0xEBFFFFFF));
    expect(
      (decoration.border! as Border).bottom.color,
      const Color(0xFF111111),
    );
  });

  testWidgets('hero contact action scrolls to Contacto and marks it active',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(
      find.descendant(
        of: find.byType(HeroWidget),
        matching: find.text('Contáctame'),
      ),
    );
    await tester.pumpAndSettle();

    expect(underlineColor(tester, 'Contacto'), const Color(0xFF0033CC));
  });

  testWidgets('the active destination underline follows the current section',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    // The wallpaper stays bright at the top, so the header uses the regular
    // text/primary roles over the hero instead of white-on-image.
    expect(underlineColor(tester, 'Inicio'), const Color(0xFF0033CC));
    expect(underlineColor(tester, 'Proyectos'), Colors.transparent);

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();

    expect(underlineColor(tester, 'Proyectos'), const Color(0xFF0033CC));
    expect(underlineColor(tester, 'Inicio'), Colors.transparent);
  });

  testWidgets('Sobre mí covers Conocimientos and Certificaciones activates',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(headerText('Sobre mí'));
    await tester.pumpAndSettle();
    expect(underlineColor(tester, 'Sobre mí'), const Color(0xFF0033CC));
    expect(
      tester.widget<HeaderWidget>(find.byType(HeaderWidget)).isOverHero,
      isFalse,
      reason: 'the header must become opaque at the hero boundary',
    );

    final scrollView = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
    final aboutOffset = scrollView.controller!.offset;
    scrollView.controller!.jumpTo(aboutOffset + 200);
    await tester.pumpAndSettle();
    expect(
      underlineColor(tester, 'Sobre mí'),
      const Color(0xFF0033CC),
      reason: 'the knowledge block belongs to the about destination',
    );

    await tester.tap(headerText('Certificaciones'));
    await tester.pumpAndSettle();
    expect(
      underlineColor(tester, 'Certificaciones'),
      const Color(0xFF0033CC),
    );
  });

  testWidgets('knowledge renders six localized cards and no Servicios heading',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    for (final label in <String>[
      'Desarrollo Android con Flutter',
      'Desarrollo iOS con Flutter',
      'Desarrollo Web',
      'Automatización & CI/CD',
      'Integración de IA Generativa',
      'Apps Script & Automatización',
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }

    expect(find.text('Conocimientos'), findsOneWidget);
    expect(find.text('Servicios'), findsNothing);
  });

  testWidgets('certifications render the full repository list', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.text('Certificaciones Técnicas'), findsOneWidget);
    expect(find.text('Gen AI: Navigate the Landscape'), findsOneWidget);
    expect(find.text('Gen AI: Unlock Foundational Concepts'), findsOneWidget);
  });

  testWidgets('mobile drawer lists all destinations and closes with Escape',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('menu-button')));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsOneWidget);
    for (final label in <String>[
      'Inicio',
      'IA',
      'Sobre mí',
      'Proyectos',
      'Certificaciones',
      'Contacto',
    ]) {
      expect(
        find.descendant(
          of: find.byType(Drawer),
          matching: find.text(label),
        ),
        findsOneWidget,
        reason: label,
      );
    }

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsNothing);
    final menuButton =
        tester.widget<IconButton>(find.byKey(const Key('menu-button')));
    expect(menuButton.focusNode?.hasFocus, isTrue);
  });

  testWidgets('drawer selection closes the drawer and scrolls the page',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('menu-button')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(
        of: find.byType(Drawer),
        matching: find.text('Proyectos'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsNothing);
    final scrollView = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
    expect(scrollView.controller!.offset, greaterThan(0));
  });

  testWidgets('reviewed widths render in both themes with header parity',
      (tester) async {
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    tester.view.devicePixelRatio = 1;

    const labels = <String>[
      'Inicio',
      'IA',
      'Sobre mí',
      'Proyectos',
      'Certificaciones',
      'Contacto',
    ];

    for (final width in <double>[360, 768, 1200, 1440, 1920]) {
      for (final mode in <ThemeMode>[ThemeMode.light, ThemeMode.dark]) {
        tester.view.physicalSize = Size(width, 900);
        await tester.pumpWidget(
          MainApp(
            key: ValueKey<String>('$width-${mode.name}'),
            initialMode: mode,
          ),
        );
        await tester.pumpAndSettle();

        final label = '${width.toInt()}px ${mode.name}';
        expect(tester.takeException(), isNull, reason: label);

        final scaffold = tester.element(find.byType(Scaffold));
        expect(
          Theme.of(scaffold).brightness,
          mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
          reason: label,
        );

        if (mode == ThemeMode.dark) {
          expect(
            find.byKey(const Key('menu-button')),
            findsNothing,
            reason: 'dark mode uses terminal navigation at $label',
          );
          for (final destination in [
            'ai',
            'about',
            'skills',
            'projects',
            'certifications',
            'contact',
          ]) {
            expect(
              find.byKey(Key('terminal-tab-$destination')),
              findsOneWidget,
              reason: destination,
            );
          }
        } else if (width >= 1200) {
          expect(
            find.byKey(const Key('menu-button')),
            findsNothing,
            reason: 'desktop header at $label',
          );
          for (final destination in labels) {
            expect(headerText(destination), findsOneWidget,
                reason: destination);
          }
        } else {
          expect(
            find.byKey(const Key('menu-button')),
            findsOneWidget,
            reason: 'mobile header at $label',
          );

          await tester.tap(find.byKey(const Key('menu-button')));
          await tester.pumpAndSettle();
          expect(find.byType(Drawer), findsOneWidget, reason: label);
          for (final destination in labels) {
            expect(
              find.descendant(
                of: find.byType(Drawer),
                matching: find.text(destination),
              ),
              findsOneWidget,
              reason: destination,
            );
          }

          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();
          expect(find.byType(Drawer), findsNothing, reason: label);
          expect(tester.takeException(), isNull, reason: label);
        }
      }
    }
  });
}
