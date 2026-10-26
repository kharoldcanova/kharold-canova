import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/data/models/project.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/ai_systems_widget.dart';

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
        home: Scaffold(
          body: SingleChildScrollView(child: child),
        ),
      ),
    );
  }

  void useWidth(WidgetTester tester, double width) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = Size(width, 1200);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
  }

  test('repository exposes the featured AI projects in a curated order', () {
    final repository = PortfolioRepository();
    final titles = repository
        .getFeaturedAiProjects()
        .map((project) => project.title)
        .toList();

    expect(titles, <String>['ia-sql', 'Alma', 'LAIN']);
    for (final project in repository.getFeaturedAiProjects()) {
      expect(project.repoUrl, isNotNull, reason: project.title);
      expect(project.localizedImpact('es'), isNotNull, reason: project.title);
      expect(project.localizedImpact('en'), isNotNull, reason: project.title);
    }

    expect(
      {
        for (final project in repository.getFeaturedAiProjects())
          project.title: project.repoUrl,
      },
      <String, String>{
        'ia-sql': 'https://github.com/kharoldcanova/ia-sql',
        'Alma': 'https://github.com/kharoldcanova/alma',
        'LAIN': 'https://github.com/kharoldcanova/lain',
      },
    );
  });

  testWidgets('AI section leads with ia-sql, Alma and LAIN',
      (tester) async {
    useWidth(tester, 1300);
    await tester.pumpWidget(harness(const AISystemsWidget()));
    await tester.pumpAndSettle();

    expect(find.text('Artificial Intelligence & Agent Systems'), findsOneWidget);
    expect(find.text('FEATURED PROJECTS'), findsOneWidget);

    final iaSql = tester.getTopLeft(find.text('ia-sql'));
    final alma = tester.getTopLeft(find.text('Alma'));
    final lain = tester.getTopLeft(find.text('LAIN'));
    expect(iaSql.dy, alma.dy);
    expect(alma.dy, lain.dy);
    expect(iaSql.dx, lessThan(alma.dx));
    expect(alma.dx, lessThan(lain.dx));

    for (final title in <String>['ia-sql', 'Alma', 'LAIN']) {
      expect(find.byKey(Key('ai-project-link-$title')), findsOneWidget);
      expect(find.byKey(Key('ai-project-$title')), findsOneWidget);
    }
    expect(find.byKey(const Key('ai-all-repos')), findsOneWidget);
  });

  testWidgets('AI section shows a localized empty state', (tester) async {
    useWidth(tester, 1300);
    await tester.pumpWidget(
      harness(const AISystemsWidget(aiProjects: <Project>[])),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI projects are being updated.'), findsOneWidget);
    expect(find.byKey(const Key('ai-all-repos')), findsOneWidget);
  });

  testWidgets('AI cards fit a narrow viewport without overflow',
      (tester) async {
    useWidth(tester, 360);
    await tester.pumpWidget(harness(const AISystemsWidget()));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('ia-sql'), findsOneWidget);
    expect(find.text('LAIN'), findsOneWidget);
  });
}
