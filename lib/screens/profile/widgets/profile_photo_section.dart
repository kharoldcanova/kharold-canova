import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

class ProfilePhotoSection extends StatelessWidget {
  final Animation<double> opacity;
  final Animation<Offset> slide;

  const ProfilePhotoSection({
    super.key,
    required this.opacity,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(
        position: slide,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.white, width: 1),
              bottom: BorderSide(color: Colors.white, width: 1),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/banner_background.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: -40,
                      bottom: -30,
                      child: IgnorePointer(
                        child: Text(
                          'KHAROLD',
                          style: TextStyle(
                            fontSize: 140,
                            color: Colors.white.withValues(alpha: 0.05),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '"${t.profile_quote}"',
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
