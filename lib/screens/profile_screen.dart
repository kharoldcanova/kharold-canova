import 'package:flutter/material.dart';
import 'package:kharoldcanova/screens/profile/widgets/profile_info_section.dart';
import 'package:kharoldcanova/screens/profile/widgets/profile_photo_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 1200);
  static const _accentColor = Colors.blueAccent;

  late final AnimationController _controller;
  late final Animation<double> _photoOpacity;
  late final Animation<Offset> _photoSlide;
  late final Animation<double> _infoOpacity;
  late final Animation<Offset> _infoSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _photoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
    );
    _photoSlide = Tween<Offset>(
      begin: const Offset(-0.2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      ),
    );

    _infoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
    );
    _infoSlide = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          secondary: _accentColor,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth > 900;

          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: _accentColor,
            ),
            child: desktop ? _desktopLayout() : _mobileLayout(),
          );
        },
      ),
    );
  }

  Widget _desktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ProfilePhotoSection(
            opacity: _photoOpacity,
            slide: _photoSlide,
          ),
        ),
        Expanded(
          flex: 5,
          child: ProfileInfoSection(
            opacity: _infoOpacity,
            slide: _infoSlide,
          ),
        ),
      ],
    );
  }

  Widget _mobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 400,
            child: ProfilePhotoSection(
              opacity: _photoOpacity,
              slide: _photoSlide,
            ),
          ),
          ProfileInfoSection(
            opacity: _infoOpacity,
            slide: _infoSlide,
          ),
        ],
      ),
    );
  }
}
