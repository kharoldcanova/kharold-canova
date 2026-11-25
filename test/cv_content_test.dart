import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/main.dart';
import 'package:kharoldcanova/screens/widgets/about_skills_widget.dart';
import 'package:kharoldcanova/screens/widgets/certifications_section.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/experience_section.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  Future<void> pumpApp(WidgetTester tester,
      {Size size = const Size(1300, 900)}) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(const MainApp());
    await tester.pumpAndSettle();
  }

  test('projects follow the CV list and order; mm2 stays under experience', () {
    expect(
      PortfolioRepository().getProjects().map((p) => p.title),
      <String>['ia-sql', 'Alma', 'LAIN', 'kharold-canova', 'design-md', 'Kipu'],
    );
  });

  test('core competencies are the five CV groups in CV order', () {
    expect(
      PortfolioRepository().getSkillGroups().map((g) => g.id),
      <String>['mobile', 'ai', 'backend', 'devops', 'frontend'],
    );
  });

  test('certifications are the four CV groups with the CV wording', () {
    final groups = PortfolioRepository().getCertificationGroups();
    expect(groups.map((g) => g.id), <String>['genai', 'ai', 'dev', 'infra']);
    expect(groups.expand((g) => g.items),
        containsAll(<String>['Python Essentials 1', 'NDG Linux Essentials']));
    expect(groups.expand((g) => g.items).join(' '), isNot(contains('EF SET')));
  });

  testWidgets('sections follow the CV order', (tester) async {
    await pumpApp(tester);

    double top(Type type) => tester.getTopLeft(find.byType(type)).dy;
    final order = <double>[
      top(HeroWidget),
      top(AboutSkillsWidget),
      top(ExperienceSection),
      top(PortfolioWidget),
      top(CertificationsSection),
      top(ContactWidget),
    ];
    expect(order, [...order]..sort());
    expect(find.text('Conocimientos'), findsNothing);
    expect(find.text('Sistemas de Inteligencia Artificial y Agentes'),
        findsNothing);
  });

  testWidgets('about shows only CV figures and the five CV groups',
      (tester) async {
    await pumpApp(tester);

    for (final entry in <String, String>{
      'years': '4',
      'users': '~115',
      'remote': '3',
    }.entries) {
      final row = find.byKey(Key('about-fact-${entry.key}'));
      expect(row, findsOneWidget, reason: entry.key);
      expect(find.descendant(of: row, matching: find.text(entry.value)),
          findsOneWidget,
          reason: entry.key);
    }
    expect(find.text('+30'), findsNothing);
    expect(find.text('Competencias clave'), findsOneWidget);
    for (final label in <String>[
      'Desarrollo móvil (Flutter)',
      'IA aplicada y automatización',
      'Backend y APIs',
      'DevOps y CI/CD',
      'Frontend web',
    ]) {
      expect(find.text(label), findsOneWidget, reason: label);
    }
  });

  testWidgets('experience uses the CV date format', (tester) async {
    await pumpApp(tester);

    expect(find.text('09/2023 — 09/2026'), findsOneWidget);
    expect(find.text('09/2022 — 07/2023'), findsOneWidget);
  });

  testWidgets('education precedes the CV certification groups', (tester) async {
    await pumpApp(tester);

    expect(find.text('Educación y certificaciones'), findsOneWidget);
    expect(find.text('Universidad César Vallejo'), findsOneWidget);
    expect(find.text('Ingeniería de Sistemas (Título Profesional)'),
        findsOneWidget);
    final educationTop =
        tester.getTopLeft(find.byKey(const Key('education-entry'))).dy;
    for (final group in <String>['genai', 'ai', 'dev', 'infra']) {
      final finder = find.byKey(Key('cert-group-$group'));
      expect(finder, findsOneWidget, reason: group);
      expect(tester.getTopLeft(finder).dy, greaterThan(educationTop));
    }
  });

  testWidgets('contact closes with availability and languages from the CV',
      (tester) async {
    await pumpApp(tester);

    expect(
      find.descendant(
        of: find.byKey(const Key('contact-availability')),
        matching: find.textContaining('Disponibilidad inmediata'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('contact-languages')),
        matching: find.textContaining('Inglés (B1 intermedio, EF SET)'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('the portfolio project card links to the live site',
      (tester) async {
    await pumpApp(tester);

    expect(find.text('kharold-canova'), findsOneWidget);
    expect(find.text('Ver sitio'), findsOneWidget);
  });
}
