import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';
import 'package:kharoldcanova/screens/banner_widget.dart';
import 'package:kharoldcanova/screens/footer_widget.dart';
import 'package:kharoldcanova/screens/proyects_widget.dart';
import 'package:kharoldcanova/screens/whaticando_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomeScreen(),
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
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        title: const Text('KHAROLD'),
        toolbarHeight: 100,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BannerWidget(),
            WhatICanDoWidget(),
            FooterWidget(),
          ],
        ),
      ),
    );
  }
}
