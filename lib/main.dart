import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/screens/banner_widget.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // un boton de menu de navegacion para ir a las otras pantallas
        leading: isSmallScreen
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // mostrar el drawer con las opciones de navegacion
                  _scaffoldKey.currentState?.openDrawer();
                },
              )
            : null,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: isSmallScreen
            ? const Text(
                'KHAROLD CANOVA',
                style: TextStyle(fontSize: 16),
              )
            : const Text(
                'KHAROLD CANOVA | FULLSTACK DEVELOPER',
                style: TextStyle(fontSize: 20),
              ),
        toolbarHeight: 100,
        clipBehavior: Clip.none,
        actions: [
          !isSmallScreen ? const NavegationRowButtons() : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              child: const Icon(
                Icons.translate,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: const MainScreen(),
      drawer: isSmallScreen ? const HomeDrawer() : null,
    );
  }
}

class NavegationRowButtons extends StatelessWidget {
  const NavegationRowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            // navegar a la pantalla de whatICanDo
          },
          child: Text(
            AppLocalizations.of(context)!.home.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // navegar a la pantalla de projects
          },
          child: Text(
            AppLocalizations.of(context)!.profile.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // navegar a la pantalla de contact
          },
          child: Text(
            AppLocalizations.of(context)!.contact.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // navegar a la pantalla de projects
          },
          child: Text(
            AppLocalizations.of(context)!.projects.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              AppLocalizations.of(context)!.menu,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.profile),
            onTap: () {
              Navigator.pop(context);
              // navegar a la pantalla de whatICanDo
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.contact),
            onTap: () {
              Navigator.pop(context);
              // navegar a la pantalla de contact
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.projects),
            onTap: () {
              Navigator.pop(context);
              // navegar a la pantalla de projects
            },
          ),
        ],
      ),
    );
  }
}
