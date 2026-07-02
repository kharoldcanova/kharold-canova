import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kharoldcanova/screens/app_shell.dart';
import 'package:kharoldcanova/screens/home_screen.dart';
import 'package:kharoldcanova/screens/profile_screen.dart';
import 'package:kharoldcanova/screens/contact_screen.dart';
import 'package:kharoldcanova/screens/projects_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeBody(),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/contact',
          name: 'contact',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ContactScreen(),
          ),
        ),
        GoRoute(
          path: '/projects',
          name: 'projects',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProjectsScreen(),
          ),
        ),
      ],
    ),
  ],
);
