import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  Future<void> pumpDarkPortfolio(WidgetTester tester,
      {Size size = const Size(390, 844)}) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MainApp(initialMode: ThemeMode.dark));
    await tester.pumpAndSettle();
  }

  testWidgets('dark mode renders the alternative terminal landing',
      (tester) async {
    await pumpDarkPortfolio(tester);

    expect(find.text('kharold@portfolio:~'), findsOneWidget);
    expect(find.text('whoami'), findsOneWidget);
    expect(find.text('Desarrollo Full Stack · IA Aplicada'), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-close')), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-minimize')), findsOneWidget);
    expect(find.byKey(const Key('terminal-window-maximize')), findsOneWidget);
    expect(find.byType(HeroWidget), findsNothing);
    for (final tab in [
      'ai',
      'about',
      'skills',
      'projects',
      'certifications',
      'contact'
    ]) {
      expect(find.byKey(Key('terminal-tab-$tab')), findsOneWidget);
    }
  });

  testWidgets('terminal tabs show portfolio content and use mono navigation',
      (tester) async {
    await pumpDarkPortfolio(tester);

    final skillsTab = tester.widget<Text>(
      find.descendant(
        of: find.byKey(const Key('terminal-tab-skills')),
        matching: find.byType(Text),
      ),
    );
    expect(skillsTab.style?.fontFamily, BrandTheme.monoFamily);

    await tester.tap(find.byKey(const Key('terminal-tab-skills')));
    await tester.pumpAndSettle();
    expect(find.text('Flutter'), findsWidgets);

    await tester.tap(find.byKey(const Key('terminal-tab-projects')));
    await tester.pumpAndSettle();
    expect(find.text('design-md'), findsOneWidget);

    await tester.tap(find.byKey(const Key('terminal-tab-contact')));
    await tester.pumpAndSettle();
    expect(find.text('kharoldcanova@gmail.com'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    final socialCardSizes = [
      for (final network in ['github', 'linkedin', 'medium'])
        tester.getSize(find.byKey(Key('terminal-contact-$network'))),
    ];
    expect(socialCardSizes.toSet(), hasLength(1));
  });

  testWidgets('terminal theme toggle returns to the light portfolio',
      (tester) async {
    await pumpDarkPortfolio(tester);

    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();

    expect(find.text('kharold@portfolio:~'), findsNothing);
    expect(find.byType(HeroWidget), findsOneWidget);
  });

  testWidgets(
      'English locale translates experience projects and certifications',
      (tester) async {
    await pumpDarkPortfolio(tester);

    await tester.tap(find.byKey(const Key('language-toggle')));
    await tester.pumpAndSettle();
    expect(find.text('Full Stack Development · Applied AI'), findsOneWidget);
    await tester.tap(find.byKey(const Key('terminal-tab-about')));
    await tester.pumpAndSettle();
    expect(find.text('Full-stack Developer'), findsNWidgets(2));
    expect(find.text('Remote (US)'), findsOneWidget);
    expect(find.textContaining('Production development'), findsOneWidget);

    await tester.tap(find.byKey(const Key('terminal-tab-projects')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Published interface-design skill'),
        findsOneWidget);
    expect(find.text('INTERNAL PROJECT'), findsWidgets);

    await tester.tap(find.byKey(const Key('terminal-tab-certifications')));
    await tester.pumpAndSettle();
    expect(find.text('July 2026'), findsWidgets);
    expect(find.text('AI-driven development: Agent Program'), findsOneWidget);
  });

  testWidgets('terminal window fits a mobile viewport without overflow',
      (tester) async {
    await pumpDarkPortfolio(tester, size: const Size(360, 780));
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
    await pumpDarkPortfolio(tester);

    await tester.pump(const Duration(seconds: 2));
    final cursor = tester.widget<FadeTransition>(
      find.byKey(const Key('terminal-cursor')),
    );
    expect(cursor.opacity.value, 1);
    expect(find.text('_'), findsOneWidget);
  });
}
