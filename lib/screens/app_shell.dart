import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kharoldcanova/bloc/locale/language_bloc.dart';
import 'package:kharoldcanova/domain/language_model.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class AppShell extends StatefulWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final currentPath = GoRouterState.of(context).uri.path;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: isSmallScreen
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
          if (!isSmallScreen) NavegationRowButtons(currentPath: currentPath),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                final bloc = context.read<LanguageBloc>();
                final current = bloc.state.selectedLanguage;

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
      body: widget.child,
      drawer: isSmallScreen ? HomeDrawer(currentPath: currentPath) : null,
    );
  }
}

class NavegationRowButtons extends StatelessWidget {
  final String currentPath;

  const NavegationRowButtons({super.key, required this.currentPath});

  static const _routeColors = {
    '/': Colors.white,
    '/profile': Colors.white,
    '/contact': Colors.white,
    '/projects': Colors.white,
  };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final items = [
      ('/', t.home.toUpperCase()),
      ('/profile', t.profile.toUpperCase()),
      ('/contact', t.contact.toUpperCase()),
      ('/projects', t.projects.toUpperCase()),
    ];

    return Row(
      children: items.map((item) {
        final route = item.$1;
        final label = item.$2;
        final isActive = currentPath == route;
        final color = _routeColors[route] ?? Colors.white;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextButton(
            onPressed: () => context.go(route),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? color : Colors.white,
                    fontSize: 18,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 2),
                if (isActive)
                  Container(
                    height: 2,
                    width: 16,
                    color: color,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  final String currentPath;

  const HomeDrawer({super.key, required this.currentPath});

  static const _routeColors = {
    '/': Colors.white,
    '/profile': Colors.lightGreen,
    '/contact': Colors.orangeAccent,
    '/projects': Colors.deepPurpleAccent,
  };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final items = [
      ('/', t.home, Icons.home),
      ('/profile', t.profile, Icons.person),
      ('/contact', t.contact, Icons.mail),
      ('/projects', t.projects, Icons.work),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              t.menu,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ...items.map((item) {
            final route = item.$1;
            final label = item.$2;
            final icon = item.$3;
            final isActive = currentPath == route;
            final color = _routeColors[route] ?? Colors.white;

            return ListTile(
              leading: Icon(icon, color: isActive ? color : null),
              title: Text(
                label,
                style: TextStyle(
                  color: isActive ? color : null,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.go(route);
              },
            );
          }),
        ],
      ),
    );
  }
}
