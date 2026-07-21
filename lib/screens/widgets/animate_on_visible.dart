import 'package:flutter/material.dart';

class AnimateOnVisible extends StatefulWidget {
  final Widget Function(BuildContext context, bool isVisible) builder;

  const AnimateOnVisible({required this.builder, super.key});

  @override
  State<AnimateOnVisible> createState() => _AnimateOnVisibleState();
}

class _AnimateOnVisibleState extends State<AnimateOnVisible> {
  bool _visible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attach();
  }

  @override
  void dispose() {
    Scrollable.of(context).position.removeListener(_onScroll);
    super.dispose();
  }

  void _attach() {
    Scrollable.of(context).position.removeListener(_onScroll);
    Scrollable.of(context).position.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  void _onScroll() {
    if (!mounted) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final scrollable = Scrollable.of(context);
    final ancestor = scrollable.context.findRenderObject() as RenderBox;
    final pos = renderBox.localToGlobal(Offset.zero, ancestor: ancestor);
    final viewport = scrollable.position.viewportDimension;
    final height = renderBox.size.height;

    final fraction = (pos.dy + height) / viewport;
    final isVisible = pos.dy < viewport * 0.85 && fraction > 0.15;

    if (isVisible != _visible) {
      setState(() => _visible = isVisible);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _visible);
}
