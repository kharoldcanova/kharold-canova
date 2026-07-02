import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 1200);

  late final AnimationController _controller;
  late final Animation<double> _nameOpacity;
  late final Animation<Offset> _nameSlide;
  late final Animation<double> _descOpacity;
  late final Animation<Offset> _descSlide;
  late final Animation<double> _buttonsOpacity;
  late final Animation<Offset> _buttonsSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _nameOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
    );
    _nameSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );
    _descOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
    );
    _descSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeOut),
      ),
    );
    _buttonsOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
    );
    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeOut),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> goToUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('No se pudo abrir $url');
    }
  }

  Future<void> openPDF() async {
    const pdfPath = 'assets/cv-flutter.pdf';
    if (!await launchUrl(Uri.parse(pdfPath))) {
      throw Exception('No se pudo abrir el PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    final translation = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        image: DecorationImage(
          image: const AssetImage('assets/banner_background.png'),
          fit: BoxFit.fitHeight,
          opacity: isSmallScreen ? 0 : 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isSmallScreen
                                  ? Image.asset(
                                      'assets/banner_background.png',
                                      fit: BoxFit.fitHeight,
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              FadeTransition(
                                opacity: _nameOpacity,
                                child: SlideTransition(
                                  position: _nameSlide,
                                  child: Text(
                                    'KHAROLD CANOVA',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  600
                                              ? 60
                                              : 80,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                color: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Text(
                                  'FULLSTACK DEVELOPER',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width < 600
                                            ? 20
                                            : 24,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeTransition(
                                opacity: _descOpacity,
                                child: SlideTransition(
                                  position: _descSlide,
                                  child: Container(
                                    width: 500,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Text(
                                          '"${translation.profile_description}"',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontStyle: FontStyle.italic,
                                              color: colorScheme.onPrimary),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: FadeTransition(
                                            opacity: _buttonsOpacity,
                                            child: SlideTransition(
                                              position: _buttonsSlide,
                                              child: !isSmallScreen
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        StackLinearButton(
                                                          icon: FontAwesomeIcons
                                                              .linkedin,
                                                          onTap: () => goToUrl(
                                                              'https://www.linkedin.com/in/kharoldcanova/'),
                                                          tooltip: 'LinkedIn',
                                                        ),
                                                        const SizedBox(
                                                            width: 24),
                                                        StackLinearButton(
                                                          icon: FontAwesomeIcons
                                                              .github,
                                                          onTap: () => goToUrl(
                                                              'https://github.com/kharoldcanova'),
                                                          tooltip: 'GitHub',
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StackLinearButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const StackLinearButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  State<StackLinearButton> createState() => _StackLinearButtonState();
}

class _StackLinearButtonState extends State<StackLinearButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 180),
        tween: Tween(begin: 0, end: _hovering ? -8 : 0),
        curve: Curves.easeOut,
        builder: (context, offset, child) {
          return Transform.translate(
            offset: Offset(0, offset),
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            _hovering ? -6 : -4,
            _hovering ? 6 : 4,
            0,
          ),
          decoration: BoxDecoration(
            color: colorScheme.secondary,
            border: Border.all(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          child: Transform.translate(
            offset: const Offset(6, -6),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                hoverColor: Colors.transparent,
                splashColor: colorScheme.primary.withValues(alpha: .15),
                highlightColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        widget.icon,
                        color: Colors.white,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.tooltip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
