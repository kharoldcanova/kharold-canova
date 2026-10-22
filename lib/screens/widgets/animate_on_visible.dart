import 'package:flutter/material.dart';

class AnimateOnVisible extends StatefulWidget {
  final Widget Function(BuildContext context, bool isVisible) builder;

  const AnimateOnVisible({required this.builder, super.key});

  @override
  State<AnimateOnVisible> createState() => _AnimateOnVisibleState();
}

class _AnimateOnVisibleState extends State<AnimateOnVisible> {
  bool _visible = false;
  bool _revealed = false;
  ScrollPosition? _position;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _visible = true;
      _revealed = true;
      return;
    }
    _attach();
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    super.dispose();
  }

  void _attach() {
    _position?.removeListener(_onScroll);
    _position = Scrollable.maybeOf(context)?.position;
    if (_position == null) {
      _visible = true;
      _revealed = true;
      return;
    }
    _position!.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  void _onScroll() {
    if (!mounted) return;
    if (_revealed || MediaQuery.disableAnimationsOf(context)) {
      if (!_visible && mounted) setState(() => _visible = true);
      _revealed = true;
      return;
    }
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    final ancestor = scrollable.context.findRenderObject() as RenderBox;
    final pos = renderBox.localToGlobal(Offset.zero, ancestor: ancestor);
    final viewport = scrollable.position.viewportDimension;
    final height = renderBox.size.height;

    final fraction = (pos.dy + height) / viewport;
    final isVisible = pos.dy < viewport * 0.85 && fraction > 0.15;

    if (isVisible) {
      _revealed = true;
      setState(() => _visible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = MediaQuery.disableAnimationsOf(context);
    final visible = disabled || _visible;
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: disabled ? Duration.zero : const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0, 0.025),
        duration: disabled ? Duration.zero : const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        child: widget.builder(context, visible),
      ),
    );
  }
}

/// Reveals a small sequence with a restrained 60ms cadence after its parent
/// section becomes visible.
class StaggeredReveal extends StatelessWidget {
  const StaggeredReveal({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AnimateOnVisible(
      builder: (context, visible) => Column(
        children: [
          for (var index = 0; index < children.length; index++)
            _StaggeredItem(
              key: ValueKey('staggered-$index'),
              visible: visible,
              delay: Duration(milliseconds: 60 * index),
              child: children[index],
            ),
        ],
      ),
    );
  }
}

class _StaggeredItem extends StatefulWidget {
  const _StaggeredItem({
    super.key,
    required this.visible,
    required this.delay,
    required this.child,
  });

  final bool visible;
  final Duration delay;
  final Widget child;

  @override
  State<_StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<_StaggeredItem> {
  bool _shown = false;

  @override
  void didUpdateWidget(covariant _StaggeredItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) _showAfterDelay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context) || widget.visible) {
      _shown = true;
    }
  }

  Future<void> _showAfterDelay() async {
    if (!MediaQuery.disableAnimationsOf(context)) {
      await Future<void>.delayed(widget.delay);
    }
    if (mounted) setState(() => _shown = true);
  }

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    final shown = reduced || _shown;
    return AnimatedOpacity(
      opacity: shown ? 1 : 0,
      duration: reduced ? Duration.zero : const Duration(milliseconds: 220),
      child: AnimatedSlide(
        offset: shown ? Offset.zero : const Offset(0, 0.015),
        duration: reduced ? Duration.zero : const Duration(milliseconds: 220),
        child: widget.child,
      ),
    );
  }
}
