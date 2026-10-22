import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/models/published_skill.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';

void main() {
  Widget harness(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(create: (_) => LanguageBloc()),
        BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
      ],
      child: MaterialApp(
        theme: AppTheme().getTheme(),
        darkTheme: AppTheme().getDarkTheme(),
        themeMode: ThemeMode.light,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('es')],
        home: child,
      ),
    );
  }

  void useWidth(WidgetTester tester, double width) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(width, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
  }

  group('header optional Medium control', () {
    testWidgets('is hidden when no URL is configured', (tester) async {
      useWidth(tester, 1300);
      await tester.pumpWidget(
        harness(
          Scaffold(
            appBar: HeaderWidget(
              activeSection: 'home',
              onSectionTap: (_) {},
              isOverHero: true,
              onMenuTap: () {},
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byTooltip('Medium'), findsNothing);
    });

    testWidgets('renders when a URL is supplied', (tester) async {
      useWidth(tester, 1300);
      await tester.pumpWidget(
        harness(
          Scaffold(
            appBar: HeaderWidget(
              activeSection: 'home',
              onSectionTap: (_) {},
              isOverHero: true,
              onMenuTap: () {},
              mediumUrl: 'https://medium.com/@kharoldcanova',
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byTooltip('Medium'), findsOneWidget);
    });

    testWidgets(
        'background is transparent over the hero and solid after scroll',
        (tester) async {
      useWidth(tester, 1300);

      await tester.pumpWidget(
        harness(
          Scaffold(
            appBar: HeaderWidget(
              activeSection: 'home',
              onSectionTap: (_) {},
              isOverHero: true,
              onMenuTap: () {},
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      final overHero = tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(HeaderWidget),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      expect(
        (overHero.decoration! as BoxDecoration).color,
        Colors.transparent,
      );

      await tester.pumpWidget(
        harness(
          Scaffold(
            appBar: HeaderWidget(
              activeSection: 'projects',
              onSectionTap: (_) {},
              isOverHero: false,
              onMenuTap: () {},
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final scrolled = tester.widget<AnimatedContainer>(
        find
            .descendant(
              of: find.byType(HeaderWidget),
              matching: find.byType(AnimatedContainer),
            )
            .first,
      );
      expect(
        (scrolled.decoration! as BoxDecoration).color,
        const Color(0xEBFFFFFF),
      );
    });
  });

  group('featured published skill', () {
    const skill = PublishedSkill(
      name: 'Flutter Skill',
      description: 'A reusable Flutter skill.',
      url: 'https://pub.dev/packages/flutter_skill',
      installCommand: 'flutter pub add flutter_skill',
    );

    testWidgets('is hidden when no skill is configured', (tester) async {
      useWidth(tester, 1300);
      await tester.pumpWidget(
        harness(
          const Scaffold(
            body: SingleChildScrollView(
              child: PortfolioWidget(projects: <Project>[]),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('PUBLISHED SKILL'), findsNothing);
    });

    testWidgets('renders name, description, command, and link when supplied',
        (tester) async {
      useWidth(tester, 1300);
      await tester.pumpWidget(
        harness(
          const Scaffold(
            body: SingleChildScrollView(
              child: PortfolioWidget(
                publishedSkill: skill,
                projects: <Project>[],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('PUBLISHED SKILL'), findsOneWidget);
      expect(find.text('Flutter Skill'), findsOneWidget);
      expect(find.text('A reusable Flutter skill.'), findsOneWidget);
      expect(find.text('flutter pub add flutter_skill'), findsOneWidget);
      expect(find.text('View skill'), findsOneWidget);
    });
  });

  group('project card', () {
    const project = Project(
      title: 'Test Project',
      description: 'Visible description',
      techStack: <String>['Flutter', 'Dart'],
      category: 'Web',
      repoUrl: 'https://example.com/project',
    );

    testWidgets(
        'keeps description and tags and only the border reacts to hover',
        (tester) async {
      useWidth(tester, 1300);
      await tester.pumpWidget(
        harness(
          const Scaffold(
            body: SingleChildScrollView(
              child: PortfolioWidget(projects: <Project>[project]),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Project'), findsOneWidget);
      expect(find.text('Visible description'), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('Dart'), findsOneWidget);

      final card = find
          .ancestor(
            of: find.text('Visible description'),
            matching: find.byType(AnimatedContainer),
          )
          .first;
      BoxDecoration decoration() =>
          tester.widget<AnimatedContainer>(card).decoration! as BoxDecoration;

      expect(decoration().boxShadow, isNull);
      expect(
        (decoration().border! as Border).top.color,
        const Color(0xFF111111),
      );

      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(tester.getCenter(card));
      await tester.pumpAndSettle();

      expect(
        (decoration().border! as Border).top.color,
        const Color(0xFF0033CC),
      );

      await mouse.moveTo(Offset.zero);
      await mouse.removePointer();
    });

    testWidgets('all project cards share the same width and height',
        (tester) async {
      useWidth(tester, 1300);
      const secondProject = Project(
        title: 'Another Project',
        description:
            'A much longer description that wraps over multiple lines to check that project cards retain matching dimensions.',
        techStack: <String>['Flutter', 'Dart', 'Firebase', 'BLoC'],
        category: 'Mobile',
      );
      await tester.pumpWidget(
        harness(
          const Scaffold(
            body: SingleChildScrollView(
              child:
                  PortfolioWidget(projects: <Project>[project, secondProject]),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final first = tester.getSize(find
          .ancestor(
            of: find.text('Visible description'),
            matching: find.byType(AnimatedContainer),
          )
          .first);
      final second = tester.getSize(find
          .ancestor(
            of: find.textContaining('A much longer description'),
            matching: find.byType(AnimatedContainer),
          )
          .first);
      expect(first.width, second.width);
      expect(first.height, second.height);
    });
  });
}
