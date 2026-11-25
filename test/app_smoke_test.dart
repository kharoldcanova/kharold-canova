import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/theme_preferences.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/experience_timeline.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/neural_networks.dart';
import 'package:kharoldcanova/screens/widgets/section_shell.dart';
import 'package:kharoldcanova/screens/widgets/skill_groups_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _primary = Color(0xFF0033CC);

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('the repository points at the main CV', () {
    expect(PortfolioRepository().getCvUrl(), 'cv-kharold-canova.pdf');
  });

  test('the CV download follows the site language and both PDFs ship', () {
    final repo = PortfolioRepository();
    expect(repo.getCvUrl('es'), 'cv-kharold-canova.pdf');
    expect(repo.getCvUrl('en'), 'cv-kharold-canova-en.pdf');
    for (final file in <String>['es', 'en'].map(repo.getCvUrl)) {
      expect(File('web/$file').existsSync(), isTrue, reason: file);
    }
  });

  test('experience data matches the CV (active users, TECLEAR dates)', () {
    final experiences = PortfolioRepository().getExperiences();
    final milMujeres = experiences.first;
    expect(milMujeres.highlights.join(' '), contains('115 personas activas'));
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
    expect(lain.techStack, contains('Hugging Face'));
  });

  test('portfolio carries the CV facts: webhooks, OpenAI-to-local, Kipu tests',
      () {
    final repo = PortfolioRepository();
    final milMujeres = repo.getExperiences().first;
    expect(milMujeres.highlights.join(' '), contains('Google Chat'));
    expect(milMujeres.highlightsEn!.join(' '), contains('Google Chat'));
    final projects = repo.getProjects();
    final iaSql = projects.firstWhere((p) => p.title == 'ia-sql');
    expect(iaSql.description, contains('OpenAI'));
    expect(iaSql.descriptionEn, contains('OpenAI'));
    final kipu = projects.firstWhere((p) => p.title == 'Kipu');
    expect(kipu.description, contains('tests'));
    expect(kipu.descriptionEn, contains('tests'));
  });

  test('dates read like a person writes them', () {
    expect(cvMonth(DateTime(2023, 9, 1)), 'sep 2023');
    expect(cvMonth(DateTime(2023, 9, 1), 'en'), 'Sep 2023');
  });

  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(390, 844),
    ThemeMode? mode,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      mode == null ? const MainApp() : MainApp(initialMode: mode),
    );
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
      find.descendant(of: link, matching: find.byType(AnimatedContainer)).first,
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

  testWidgets('first visit is light, with the name and no avatar in the hero',
      (tester) async {
    await pumpApp(tester);

    final scaffold = tester.element(find.byType(Scaffold));
    expect(Theme.of(scaffold).brightness, Brightness.light);
    expect(find.byKey(const Key('hero-name')), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNothing);
    expect(find.text('Descargar CV ↗'), findsOneWidget);
  });

  for (final size in <Size>[const Size(390, 844), const Size(1300, 900)]) {
    testWidgets('hero shows the role, availability and links at ${size.width}',
        (tester) async {
      await pumpApp(tester, size: size);

      expect(find.text('HOLA, SOY'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(HeroWidget),
          matching: find.text('Disponibilidad inmediata'),
        ),
        findsOneWidget,
      );
      expect(
        find.textContaining('Desarrollador full stack, entre',
            findRichText: true),
        findsOneWidget,
      );
      expect(find.byType(NeuralNetworks), findsOneWidget);
      for (final key in <String>[
        'hero-projects',
        'hero-cv',
        'hero-github',
        'hero-linkedin',
        'hero-medium',
      ]) {
        expect(find.byKey(Key(key)), findsOneWidget, reason: key);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the hero copy has no CV boilerplate', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));
    expect(find.textContaining('TIEMPO COMPLETO'), findsNothing);
    expect(find.textContaining('Pregúntale'), findsNothing);
    expect(find.textContaining('PIURA, PERÚ ·'), findsNothing);
  });

  for (final size in <Size>[const Size(390, 844), const Size(1300, 900)]) {
    for (final mode in <ThemeMode>[ThemeMode.light, ThemeMode.dark]) {
      testWidgets('hero uses ink roles at ${size.width.toInt()}px ${mode.name}',
          (tester) async {
        await pumpApp(tester, size: size, mode: mode);

        final scheme =
            Theme.of(tester.element(find.byType(Scaffold))).colorScheme;
        final name = tester.widget<Text>(find.byKey(const Key('hero-name')));
        expect(name.style?.color, scheme.onSurface);
      });
    }
  }

  testWidgets('neural networks wake on hover and rest afterwards',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));
    // After the intro the ticker stops: an idle page schedules no frames.
    expect(tester.binding.hasScheduledFrame, isFalse);

    final networks = find.byType(NeuralNetworks);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    addTearDown(mouse.removePointer);
    await mouse.addPointer(location: Offset.zero);
    await mouse.moveTo(tester.getCenter(networks));
    await tester.pump(const Duration(milliseconds: 16));
    expect(tester.binding.hasScheduledFrame, isTrue);

    await tester.pump(const Duration(seconds: 1));
    await mouse.moveTo(Offset.zero);
    await tester.pumpAndSettle();
    expect(tester.binding.hasScheduledFrame, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('neural networks stack and react to taps on a phone',
      (tester) async {
    await pumpApp(tester);
    final networks = find.byType(NeuralNetworks);
    await tester.ensureVisible(networks);
    await tester.pumpAndSettle();

    expect(tester.getSize(networks).height, 480);
    await tester.tapAt(tester.getCenter(networks));
    await tester.pump(const Duration(milliseconds: 16));
    expect(tester.binding.hasScheduledFrame, isTrue);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion keeps the networks still', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1300, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await tester.pumpWidget(const MainApp());
    await tester.pump();
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('hero projects action scrolls to Proyectos and marks it active',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(find.byKey(const Key('hero-projects')));
    await tester.pumpAndSettle();

    expect(underlineColor(tester, 'Proyectos'), _primary);
  });

  testWidgets('contact: blue block, availability, channels and quiet meta line',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    final section = tester.widget<SectionContainer>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.byType(SectionContainer),
      ),
    );
    expect(section.background, _primary);

    final title = tester.widget<Text>(find.text('Hablemos'));
    expect(title.style?.color, Colors.white);
    for (final key in <String>[
      'contact-availability',
      'contact-github',
      'contact-linkedin',
      'contact-copy-email',
      'contact-meta',
    ]) {
      expect(find.byKey(Key(key)), findsOneWidget, reason: key);
    }
    expect(find.textContaining('Piura, Perú (UTC−5)'), findsOneWidget);
    // Location no longer sits in "Sobre mí".
    expect(find.textContaining('Vivo en Piura'), findsNothing);
  });

  testWidgets('the copy button puts the email on the clipboard',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null));

    final button = find.byKey(const Key('contact-copy-email'));
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(copied, 'kharoldcanova@gmail.com');
    expect(find.text('Email copiado'), findsOneWidget);
  });

  testWidgets('dark contact uses the elevated surface and primary text',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();

    final section = tester.widget<SectionContainer>(
      find.descendant(
        of: find.byType(ContactWidget),
        matching: find.byType(SectionContainer),
      ),
    );
    expect(section.background, BrandColors.darkBgElevated);
    final title = tester.widget<Text>(find.text('Hablemos'));
    expect(title.style?.color, BrandColors.darkTextPrimary);
  });

  testWidgets('about shows the photo and the four CV metrics', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.byKey(const Key('about-photo')), findsOneWidget);
    for (final key in <String>['years', 'users', 'stores', 'remote']) {
      expect(find.byKey(Key('about-fact-$key')), findsOneWidget, reason: key);
    }
    expect(find.text('~115'), findsOneWidget);
  });

  testWidgets('experience and skills render the CV content', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.byType(ExperienceTimeline), findsOneWidget);
    expect(find.text('Mil Mujeres Legal Services'), findsOneWidget);
    expect(find.text('Desarrollador Full Stack'), findsNWidgets(2));
    expect(find.text('TECLEAR S.A.C.'), findsOneWidget);
    expect(find.text('sep 2023 – sep 2026'), findsOneWidget);

    expect(find.text('Con qué trabajo'), findsOneWidget);
    for (final technology in <String>[
      'RAG con LlamaIndex',
      'GitHub Actions',
      'Clean Architecture',
      'MySQL',
    ]) {
      expect(
        find.descendant(
          of: find.byType(SkillGroupsGrid),
          matching: find.textContaining(technology),
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

  testWidgets('header: four links, language, theme and CV; nothing else',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    for (final label in <String>[
      'Sobre mí',
      'Experiencia',
      'Proyectos',
      'Contacto',
    ]) {
      expect(headerText(label), findsOneWidget, reason: label);
    }
    for (final key in <String>[
      'language-toggle',
      'theme-toggle',
      'header-cv'
    ]) {
      expect(find.byKey(Key(key)), findsOneWidget, reason: key);
    }
    for (final key in <String>[
      'presentation-control',
      'header-github',
      'header-linkedin',
    ]) {
      expect(find.byKey(Key(key)), findsNothing, reason: key);
    }

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();
    final scrollView = tester
        .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
    expect(scrollView.controller!.offset, greaterThan(0));

    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();
    expect(headerText('About me'), findsOneWidget);
    expect(headerText('Projects'), findsOneWidget);
  });

  testWidgets('English hero and contact read naturally', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));
    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();

    expect(find.text("HI, I'M"), findsOneWidget);
    expect(find.text('Available now'), findsNWidgets(2));
    expect(find.text("Let's talk"), findsOneWidget);
    expect(find.text('Download CV ↗'), findsOneWidget);
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
    expect((decoration.border! as Border).bottom.color, Colors.transparent);

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();

    decoration = headerDecoration(tester);
    expect(decoration.color, BrandColors.lightNavSurface);
    expect(
      (decoration.border! as Border).bottom.color,
      BrandColors.lightBorderSubtle,
    );
  });

  testWidgets('the active destination underline follows the current section',
      (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(underlineColor(tester, 'Proyectos'), Colors.transparent);

    await tester.tap(headerText('Proyectos'));
    await tester.pumpAndSettle();
    expect(underlineColor(tester, 'Proyectos'), _primary);

    await tester.tap(headerText('Sobre mí'));
    await tester.pumpAndSettle();
    expect(underlineColor(tester, 'Sobre mí'), _primary);
    expect(underlineColor(tester, 'Proyectos'), Colors.transparent);
    expect(
      tester.widget<HeaderWidget>(find.byType(HeaderWidget)).isOverHero,
      isFalse,
      reason: 'the header must become opaque past the hero',
    );
  });

  testWidgets('certifications render the full repository list', (tester) async {
    await pumpApp(tester, size: const Size(1300, 900));

    expect(find.text('Formación y certificaciones'), findsOneWidget);
    expect(find.text('Gen AI: Navigate the Landscape'), findsOneWidget);
    expect(find.text('Gen AI: Unlock Foundational Concepts'), findsOneWidget);
  });

  const drawerLabels = <String>[
    'Inicio',
    'Sobre mí',
    'Experiencia',
    'Proyectos',
    'Formación',
    'Contacto',
  ];

  testWidgets('mobile drawer lists all destinations and closes with Escape',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.byKey(const Key('menu-button')));
    await tester.pumpAndSettle();

    expect(find.byType(Drawer), findsOneWidget);
    for (final label in drawerLabels) {
      expect(
        find.descendant(of: find.byType(Drawer), matching: find.text(label)),
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

  testWidgets('reviewed widths render in both themes without overflow',
      (tester) async {
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    tester.view.devicePixelRatio = 1;

    for (final width in <double>[320, 360, 390, 768, 900, 1200, 1440, 1920]) {
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

        // Scroll through the whole page so every section lays out.
        final scrollView = tester
            .widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
        final controller = scrollView.controller!;
        controller.jumpTo(controller.position.maxScrollExtent);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$label bottom');

        if (width >= kHeaderInlineNavWidth) {
          expect(find.byKey(const Key('menu-button')), findsNothing,
              reason: label);
        } else {
          expect(find.byKey(const Key('menu-button')), findsOneWidget,
              reason: label);
          await tester.tap(find.byKey(const Key('menu-button')));
          await tester.pumpAndSettle();
          for (final destination in drawerLabels) {
            expect(
              find.descendant(
                of: find.byType(Drawer),
                matching: find.text(destination),
              ),
              findsOneWidget,
              reason: '$destination at $label',
            );
          }
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
          await tester.pumpAndSettle();
        }
      }
    }
  });
}
