import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/domain/language_model.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(create: (_) => LanguageBloc()),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Kharold Canova',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().getTheme(),
            home: const HomeScreen(),
            locale: state.selectedLanguage.value,
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
        },
      ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                final bloc = context.read<LanguageBloc>();
                final current = bloc.state.selectedLanguage;

                // Alternamos entre idiomas usando el enum
                final newLang = current == Language.english
                    ? Language.spanish
                    : Language.english;

                bloc.add(ChangeLanguage(selectedLanguage: newLang));
              },
              child: Icon(
                Icons.translate,
                color: theme.colorScheme.onSurface,
                size: 30,
              ),
            ),
          ),
        ],
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
