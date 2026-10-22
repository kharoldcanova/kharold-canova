import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/bloc/theme/theme_bloc.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/config/theme/theme_preferences.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/portfolio_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialMode = await ThemePreferences.load();
  runApp(MainApp(initialMode: initialMode));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.initialMode = ThemeMode.light});

  final ThemeMode initialMode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(create: (_) => LanguageBloc()),
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(initialMode: initialMode),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Kharold Canova — AI & DevOps Engineer',
                debugShowCheckedModeBanner: false,
                theme: AppTheme().getTheme(),
                darkTheme: AppTheme().getDarkTheme(),
                themeMode: themeState.mode,
                home: const PortfolioPage(),
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
          );
        },
      ),
    );
  }
}
