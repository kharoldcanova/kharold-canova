import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/data/repository/portfolio_repository.dart';
import 'package:kharoldcanova/screens/widgets/about_skills_widget.dart';
import 'package:kharoldcanova/screens/widgets/certifications_section.dart';
import 'package:kharoldcanova/screens/widgets/contact_widget.dart';
import 'package:kharoldcanova/screens/widgets/experience_section.dart';
import 'package:kharoldcanova/screens/widgets/footer_widget.dart';
import 'package:kharoldcanova/screens/widgets/header_widget.dart';
import 'package:kharoldcanova/screens/widgets/hero_widget.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_drawer.dart';
import 'package:kharoldcanova/screens/widgets/portfolio_widget.dart';
import 'package:kharoldcanova/screens/widgets/presentation_page.dart';
import 'package:kharoldcanova/screens/widgets/terminal_landing_page.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _menuFocusNode = FocusNode();
  final _repo = PortfolioRepository();

  final _sectionKeys = <String, GlobalKey>{
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'certifications': GlobalKey(),
    'contact': GlobalKey(),
  };

  String _activeSection = 'home';
  bool _isOverHero = true;
  double _heroHeight = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _menuFocusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Keep a 1px tolerance so tapping a section that starts exactly at the
    // hero boundary does not leave the header transparent over the hero edge.
    final heroThreshold = (_heroHeight - BrandTheme.headerHeight - 1)
        .clamp(0.0, double.infinity)
        .toDouble();
    final isOverHero = _scrollController.offset < heroThreshold;
    if (isOverHero != _isOverHero) {
      setState(() => _isOverHero = isOverHero);
    }

    var active = 'home';
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= BrandTheme.headerHeight + 24) {
        active = entry.key;
      }
    }

    // The last section can be shorter than the viewport, so its top may never
    // reach the header threshold. At the bottom of the page, activate it
    // explicitly so the final destination is reachable.
    final position = _scrollController.position;
    if (position.maxScrollExtent > 0 &&
        _scrollController.offset >= position.maxScrollExtent - 8) {
      active = _sectionKeys.keys.last;
    }

    if (active != _activeSection) {
      setState(() => _activeSection = active);
    }
  }

  void _scrollToSection(String section) {
    final ctx = _sectionKeys[section]?.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !_scrollController.hasClients) return;

    final target = (_scrollController.offset +
            box.localToGlobal(Offset.zero).dy -
            BrandTheme.headerHeight)
        .clamp(0.0, _scrollController.position.maxScrollExtent);

    setState(() => _activeSection = section);
    _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
    _menuFocusNode.requestFocus();
  }

  List<({String id, Widget child})> _buildSections({
    required String cvUrl,
    required double height,
  }) {
    Widget reveal(Widget child) => AnimateOnVisible(
          builder: (context, isVisible) => child,
        );
    return [
      (
        id: 'home',
        child: reveal(HeroWidget(
          cvUrl: cvUrl,
          onContact: () => _scrollToSection('contact'),
          onViewProjects: () => _scrollToSection('projects'),
          height: height,
        )),
      ),
      (
        id: 'about',
        child: reveal(
          AboutSkillsWidget(onHireMe: () => _scrollToSection('contact')),
        ),
      ),
      (id: 'experience', child: reveal(const ExperienceSection())),
      (id: 'projects', child: reveal(const PortfolioWidget())),
      (id: 'certifications', child: reveal(const CertificationsSection())),
      (id: 'contact', child: reveal(const ContactWidget())),
    ];
  }

  void _openPresentation() {
    Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        fullscreenDialog: true,
        pageBuilder: (_, __, ___) => PresentationPage(
          slides: _buildSections(
                  cvUrl: _repo
                      .getCvUrl(Localizations.localeOf(context).languageCode),
                  height: _heroHeight)
              .map((section) => section.child)
              .toList(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (MediaQuery.disableAnimationsOf(context)) return child;
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _openTerminal() {
    Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        fullscreenDialog: true,
        pageBuilder: (_, __, ___) => const TerminalLandingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (MediaQuery.disableAnimationsOf(context)) return child;
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmallScreen = width < 1200;
    _heroHeight = heroHeightFor(context);

    final mediumUrl = _repo.getMedium();
    final cvUrl = _repo.getCvUrl(Localizations.localeOf(context).languageCode);
    final sections = _buildSections(cvUrl: cvUrl, height: _heroHeight);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: HeaderWidget(
        activeSection: _activeSection,
        onSectionTap: _scrollToSection,
        isOverHero: _isOverHero,
        onMenuTap: _openDrawer,
        onPresentationTap: _openPresentation,
        mediumUrl: mediumUrl,
        cvUrl: cvUrl,
        menuFocusNode: _menuFocusNode,
      ),
      drawer: isSmallScreen
          ? PortfolioDrawer(
              activeSection: _activeSection,
              onSectionTap: _scrollToSection,
              onClose: _closeDrawer,
              onPresentationTap: _openPresentation,
              cvUrl: cvUrl,
              mediumUrl: mediumUrl,
            )
          : null,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            for (final section in sections)
              Container(
                key: _sectionKeys[section.id],
                child: section.child,
              ),
            FooterWidget(
              mediumUrl: mediumUrl,
              onTerminalTap: _openTerminal,
            ),
          ],
        ),
      ),
    );
  }
}
