import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/home_screen.dart';

void main() {
  testWidgets('HomeBody renders name, title, social buttons and animates',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme().getTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: HomeBody()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('KHAROLD CANOVA'), findsOneWidget);
    expect(find.text('FULLSTACK DEVELOPER'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
  });
}
