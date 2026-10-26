import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';
import 'package:kharoldcanova/screens/widgets/about_skills_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';
import 'package:kharoldcanova/screens/widgets/presentation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  Future<void> pumpPortfolio(WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1400, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
  }

  testWidgets('header presentation control opens six slides with keyboard exit',
      (tester) async {
    await pumpPortfolio(tester);
    await tester.tap(find.descendant(
      of: find.byType(HeaderWidget),
      matching: find.text('Proyectos'),
    ));
    await tester.pumpAndSettle();
    final priorOffset = Scrollable.of(
      tester.element(find.byType(PortfolioWidget)),
    ).position.pixels;
    expect(priorOffset, greaterThan(0));

    await tester.tap(find.byTooltip('Iniciar presentación'));
    await tester.pumpAndSettle();
    expect(find.byType(PresentationPage), findsOneWidget);
    expect(find.text('1 / 6'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    expect(find.text('2 / 6'), findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.byType(PresentationPage), findsNothing);
    expect(find.byType(HeroWidget), findsOneWidget);
    expect(
      Scrollable.of(tester.element(find.byType(PortfolioWidget)))
          .position
          .pixels,
      closeTo(priorOffset, 1),
    );
  });

  testWidgets('presentation navigation controls stay within first and last',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme().getTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      home: const PresentationPage(
        slides: [Text('slide one'), Text('slide two')],
      ),
    ));
    expect(find.text('1 / 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Next slide'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Next slide'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);
  });

  testWidgets('mobile drawer exposes the localized presentation destination',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('menu-button')));
    await tester.pumpAndSettle();
    expect(find.text('Iniciar presentación'), findsOneWidget);
    await tester.tap(find.text('Iniciar presentación'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 6'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dark theme uses the near-black base token', (tester) async {
    await pumpPortfolio(tester);
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    expect(BrandColors.darkBgBase, Colors.black);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first))
          .scaffoldBackgroundColor,
      Colors.black,
    );
  });

  testWidgets('Medium link is configured and impact counts animate on arrival',
      (tester) async {
    await pumpPortfolio(tester);
    expect(find.byTooltip('Medium'), findsWidgets);

    await Scrollable.ensureVisible(
      tester.element(find.byType(AboutSkillsWidget)),
      duration: Duration.zero,
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 1500));
    final years =
        PortfolioRepository().getTotalYearsExperience().toStringAsFixed(1);
    expect(find.text('+$years'), findsOneWidget);
    expect(find.text('+30'), findsOneWidget);
  });

  testWidgets('hero has no image ownership credit and dark theme is green',
      (tester) async {
    await pumpPortfolio(tester);
    expect(find.textContaining('Karem Adem'), findsNothing);
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();
    expect(BrandColors.darkPrimary, const Color(0xFF4ADE80));
  });

  testWidgets('dark mode uses the terminal landing and mono navigation',
      (tester) async {
    await pumpPortfolio(tester);
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pumpAndSettle();

    expect(find.text('kharold@portfolio:~'), findsOneWidget);
    expect(find.byType(HeroWidget), findsNothing);
    final tab = tester.widget<Text>(
      find.descendant(
        of: find.byKey(const Key('terminal-tab-about')),
        matching: find.byType(Text),
      ),
    );
    expect(tab.style?.fontFamily, BrandTheme.monoFamily);
  });

  testWidgets('light hero displays its image without a darkening overlay',
      (tester) async {
    await pumpPortfolio(tester);

    expect(
      find.descendant(
        of: find.byType(HeroWidget),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/hero-desktop.webp',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(HeroWidget),
        matching: find.byType(DecoratedBox),
      ),
      findsNothing,
    );
  });

  testWidgets('presentation slide fits the viewport without scrolling',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme().getTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      home: const PresentationPage(slides: [Text('full screen content')]),
    ));
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.text('full screen content'), findsOneWidget);
  });

  testWidgets('AnimateOnVisible reveals once and bypasses motion when reduced',
      (tester) async {
    var disabled = false;
    await tester.pumpWidget(Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: disabled),
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AnimateOnVisible(
                builder: (_, visible) => Text(visible ? 'visible' : 'waiting'),
              ),
            ),
          ),
        ),
      );
    }));
    await tester.pump(const Duration(milliseconds: 550));
    expect(find.text('visible'), findsOneWidget);

    disabled = true;
    await tester.pumpWidget(MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: AnimateOnVisible(
              builder: (_, visible) =>
                  Text(visible ? 'reduced final' : 'hidden'),
            ),
          ),
        ),
      ),
    ));
    await tester.pump();
    final opacity =
        tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
    final slide = tester.widget<AnimatedSlide>(find.byType(AnimatedSlide));
    expect(find.text('reduced final'), findsOneWidget);
    expect(opacity.opacity, 1);
    expect(slide.offset, Offset.zero);
    expect(opacity.duration, Duration.zero);
  });

  testWidgets('hero uses the owner wallpaper crops rather than placeholders',
      (tester) async {
    await pumpPortfolio(tester);
    final assets = tester.widgetList<Image>(find.byType(Image)).where(
          (image) => image.image is AssetImage,
        );
    expect(
      assets.map((image) => (image.image as AssetImage).assetName),
      contains('assets/hero-desktop.webp'),
    );
    expect(
      assets.map((image) => (image.image as AssetImage).assetName),
      isNot(contains('assets/photo.jpg')),
    );
    expect(find.textContaining('Karem Adem'), findsNothing);
  });
}
