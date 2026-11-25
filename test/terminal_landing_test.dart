import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/terminal_landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  Future<void> pumpPortfolio(
    WidgetTester tester, {
    Size size = const Size(390, 844),
    ThemeMode mode = ThemeMode.light,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(MainApp(initialMode: mode));
    await tester.pumpAndSettle();
  }

  Future<void> openTerminal(WidgetTester tester) async {
    final button = find.byKey(const Key('terminal-open'));
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  testWidgets('dark mode renders the same portfolio instead of the terminal',
      (tester) async {
    await pumpPortfolio(tester, mode: ThemeMode.dark);

    expect(find.byType(HeroWidget), findsOneWidget);
    expect(find.byType(HeaderWidget), findsOneWidget);
    expect(find.byType(TerminalLandingPage), findsNothing);
    expect(find.text('kharold@portfolio:~'), findsNothing);
  });

  testWidgets('footer terminal button opens the terminal easter egg',
      (tester) async {
    await pumpPortfolio(tester);
    await openTerminal(tester);

    expect(find.text('kharold@portfolio:~'), findsOneWidget);
    expect(find.text('whoami'), findsOneWidget);
    expect(find.text('Desarrollo Full Stack · IA Aplicada'), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-close')), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-minimize')), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-maximize')), findsOneWidget);
    for (final tab in [
      'about',
      'experience',
      'skills',
      'projects',
      'certifications',
      'contact'
    ]) {
      expect(find.byKey(Key('terminal-tab-$tab')), findsOneWidget);
    }
  });

  testWidgets('terminal keeps its own dark mono look from the light site',
      (tester) async {
    await pumpPortfolio(tester);
    await openTerminal(tester);

    final terminalContext =
        tester.element(find.byKey(const Key('terminal-window')));
    expect(Theme.of(terminalContext).brightness, Brightness.dark);
    expect(
      Theme.of(terminalContext).textTheme.bodyLarge?.fontFamily,
      BrandTheme.monoFamily,
    );
  });

  for (final exit in ['button', 'window-dot', 'escape']) {
    testWidgets('terminal closes back to the portfolio via $exit',
        (tester) async {
      await pumpPortfolio(tester);
      await openTerminal(tester);

      switch (exit) {
        case 'button':
          await tester.tap(find.byKey(const Key('terminal-exit')));
        case 'window-dot':
          await tester.tap(find.byKey(const Key('terminal-window-close')));
        case 'escape':
          await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      }
      await tester.pumpAndSettle();

      expect(find.byType(TerminalLandingPage), findsNothing);
      expect(find.byType(HeroWidget), findsOneWidget);
    });
  }

  testWidgets('terminal tabs show portfolio content and use mono navigation',
      (tester) async {
    await pumpPortfolio(tester);
    await openTerminal(tester);

    final skillsTab = tester.widget<Text>(
      find.descendant(
        of: find.byKey(const Key('terminal-tab-skills')),
        matching: find.byType(Text),
      ),
    );
    expect(skillsTab.style?.fontFamily, BrandTheme.monoFamily);

    await tester.tap(find.byKey(const Key('terminal-tab-skills')));
    await tester.pumpAndSettle();
    expect(find.text('Dart'), findsWidgets);

    await tester.tap(find.byKey(const Key('terminal-tab-projects')));
    await tester.pumpAndSettle();
    expect(find.text('design-md'), findsWidgets);

    await tester.tap(find.byKey(const Key('terminal-tab-contact')));
    await tester.pumpAndSettle();
    expect(find.text('kharoldcanova@gmail.com'), findsWidgets);
    final socialCardSizes = [
      for (final network in ['github', 'linkedin', 'medium'])
        tester.getSize(find.byKey(Key('terminal-contact-$network'))),
    ];
    expect(socialCardSizes.toSet(), hasLength(1));
  });

  testWidgets(
      'English locale translates experience projects and certifications',
      (tester) async {
    await pumpPortfolio(tester);
    await openTerminal(tester);

    await tester.tap(find.byKey(const Key('terminal-language-toggle')));
    await tester.pumpAndSettle();
    expect(find.text('Full Stack Development · Applied AI'), findsOneWidget);
    await tester.tap(find.byKey(const Key('terminal-tab-experience')));
    await tester.pumpAndSettle();
    expect(find.text('Full Stack Developer'), findsNWidgets(2));
    expect(find.text('USA (remote from Peru)'), findsOneWidget);
    expect(find.textContaining('Sole owner of mm2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('terminal-tab-projects')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Published interface-design skill'),
        findsOneWidget);
    expect(find.text('INTERNAL PROJECT'), findsWidgets);

    await tester.tap(find.byKey(const Key('terminal-tab-certifications')));
    await tester.pumpAndSettle();
    expect(find.text('Introduction to Generative AI'), findsOneWidget);
    expect(
      find.text('BIG School · AI Development: Agent Program (2026)'),
      findsOneWidget,
    );
  });

  testWidgets('terminal window fits a mobile viewport without overflow',
      (tester) async {
    await pumpPortfolio(tester, size: const Size(360, 780));
    await openTerminal(tester);
    expect(tester.getSize(find.byKey(const Key('terminal-window'))).width, 328);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion keeps the terminal cursor visible',
      (tester) async {
    tester.binding.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(
      tester.binding.platformDispatcher.clearAccessibilityFeaturesTestValue,
    );
    await pumpPortfolio(tester);
    await openTerminal(tester);

    await tester.pump(const Duration(seconds: 2));
    final cursor = tester.widget<FadeTransition>(
      find.byKey(const Key('terminal-cursor')),
    );
    expect(cursor.opacity.value, 1);
    expect(find.text('_'), findsOneWidget);
  });
}
