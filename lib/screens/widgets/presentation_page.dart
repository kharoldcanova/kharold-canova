import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharoldcanova/screens/widgets/presentation_slide.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key, required this.slides});

  final List<Widget> slides;

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, widget.slides.length - 1);
    if (next == _index) return;
    setState(() => _index = next);
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.jumpToPage(next);
    } else {
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _go(1),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _go(-1),
        const SingleActivator(LogicalKeyboardKey.space): () => _go(1),
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).pop(),
      },
      child: Focus(
        autofocus: true,
        child: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.slides.length,
          itemBuilder: (context, index) => PresentationSlide(
            key: ValueKey('presentation-slide-$index'),
            index: index,
            count: widget.slides.length,
            onPrevious: () => _go(-1),
            onNext: () => _go(1),
            onClose: () => Navigator.of(context).pop(),
            child: widget.slides[index],
          ),
        ),
      ),
    );
  }
}
