import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/screens/banner_widget.dart';
import 'package:kharoldcanova/screens/footer_widget.dart';
import 'package:kharoldcanova/screens/proyects_widget.dart';
import 'package:kharoldcanova/screens/whaticando_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kharold Canova',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomeScreen(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text('KHAROLD'),
        toolbarHeight: 100,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(),
            WhatICanDoWidget(),
            ProyectsWidget(),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
