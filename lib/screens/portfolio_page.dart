import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:kharoldcanova/screens/widgets/about_skills_widget.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/footer_widget.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';
import 'package:kharoldcanova/screens/widgets/services_widget.dart';
import 'package:kharoldcanova/screens/widgets/stats_footer_widget.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();

  final _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'services': GlobalKey(),
    'contact': GlobalKey(),
  };

  String _activeSection = 'home';

  void _scrollToSection(String section) {
    setState(() => _activeSection = section);

    final ctx = _sectionKeys[section]?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.08,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    String? closest;
    double minDist = double.infinity;

    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;

      final offset = box.localToGlobal(Offset.zero).dy.abs();
      if (offset < minDist) {
        minDist = offset;
        closest = entry.key;
      }
    }

    if (closest != null && _activeSection != closest) {
      setState(() => _activeSection = closest!);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 1200;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HeaderWidget(
        activeSection: _activeSection,
        onSectionTap: _scrollToSection,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(key: _sectionKeys['home'], child: const HeroWidget()),
            Container(
                key: _sectionKeys['about'], child: AboutSkillsWidget(onHireMe: () => _scrollToSection('contact'))),
            const StatsFooterWidget(),
            Container(
                key: _sectionKeys['projects'], child: const PortfolioWidget()),
            Container(
                key: _sectionKeys['services'], child: const ServicesWidget()),
            Container(
              key: _sectionKeys['contact'],
              child: const ContactWidget(),
            ),
            const FooterWidget(),
          ],
        ),
      ),
      drawer: isSmallScreen
          ? Drawer(
              child: Container(
                color: colorScheme.surface,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: colorScheme.primary),
                      child: Text(
                        t.menu,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    _DrawerItem(
                      label: t.home,
                      icon: Icons.home,
                      isActive: _activeSection == 'home',
                      colorScheme: colorScheme,
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection('home');
                      },
                    ),
                    _DrawerItem(
                      label: t.about,
                      icon: Icons.person,
                      isActive: _activeSection == 'about',
                      colorScheme: colorScheme,
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection('about');
                      },
                    ),
                    _DrawerItem(
                      label: t.projects,
                      icon: Icons.work,
                      isActive: _activeSection == 'projects',
                      colorScheme: colorScheme,
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection('projects');
                      },
                    ),
                    _DrawerItem(
                      label: t.contact,
                      icon: Icons.mail,
                      isActive: _activeSection == 'contact',
                      colorScheme: colorScheme,
                      onTap: () {
                        Navigator.pop(context);
                        _scrollToSection('contact');
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? colorScheme.primary : colorScheme.onSurface,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? colorScheme.primary : colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      onTap: onTap,
    );
  }
}
