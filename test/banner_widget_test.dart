import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/banner_widget.dart';

void main() {
  testWidgets('BannerWidget renders gradient, buttons, and animates',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme().getTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: MainScreen()),
      ),
    );

    // Let animations complete
    await tester.pumpAndSettle();

    // Verify a DecoratedBox with a LinearGradient exists (the gradient
    // background that replaces the video)
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is DecoratedBox &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).gradient is LinearGradient,
      ),
      findsOneWidget,
    );

    // Verify all three buttons render
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
  });
}
