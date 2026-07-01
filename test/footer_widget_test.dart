import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/footer_widget.dart';

void main() {
  testWidgets('Footer second container uses surface background color',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme().getTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: FooterWidget()),
      ),
    );

    // Find all Container widgets
    final containers = find.byType(Container);

    // There should be at least 2 containers in the footer
    expect(containers, findsAtLeast(2));

    // The second container is the contact info section
    final secondContainer = tester.widget<Container>(containers.at(1));
    expect(
      secondContainer.color,
      Theme.of(
        tester.element(find.byType(FooterWidget)),
      ).colorScheme.surface,
    );
  });
}
