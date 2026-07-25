import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kharoldcanova/screens/widgets/animate_on_visible.dart';

// ---------------------------------------------------------------------------
// Data Models
// ---------------------------------------------------------------------------

/// A single axis (spoke) of the radar chart.
class RadarAxis {
  final String label;
  final double value; // 0.0 → 1.0
  final Color color; // distinctive color per axis

  const RadarAxis({
    required this.label,
    required this.value,
    required this.color,
  });
}

// ---------------------------------------------------------------------------
// Default dataset — edit values AND colors to match your profile.
// ---------------------------------------------------------------------------

const kDefaultRadarData = [
  RadarAxis(
    label: 'Móvil / Dart (Flutter)',
    value: 1.0,
    color: Color(0xFF00D4FF),
  ),
  RadarAxis(
    label: 'Backend / APIs (Laravel, FastAPI)',
    value: 0.80,
    color: Color(0xFFFF6B6B),
  ),
  RadarAxis(
    label: 'Bases de Datos (MySQL, SQL)',
    value: 0.50,
    color: Color(0xFF4ADE80),
  ),
  RadarAxis(
    label: 'DevOps & CI/CD (Git, Docker)',
    value: 0.70,
    color: Color(0xFFFF9F43),
  ),
  RadarAxis(
    label: 'Entorno & OS (Linux)',
    value: 0.70,
    color: Color(0xFFA78BFA),
  ),
  RadarAxis(
    label: 'Frontend Web (Vue.js)',
    value: 0.80,
    color: Color(0xFFFBBF24),
  ),
];

// ---------------------------------------------------------------------------
// Widget: RadarSkillsChart
// ---------------------------------------------------------------------------

class RadarSkillsChart extends StatefulWidget {
  final List<RadarAxis> axes;
  final String? title;
  final String? subtitle;

  const RadarSkillsChart({
    super.key,
    this.axes = kDefaultRadarData,
    this.title,
    this.subtitle,
  });

  @override
  State<RadarSkillsChart> createState() => _RadarSkillsChartState();
}

class _RadarSkillsChartState extends State<RadarSkillsChart>
    with SingleTickerProviderStateMixin {
  static const _tickLabels = [
    'Exploración',
    'Competente',
    'Avanzado',
    'Producción',
  ];

  static const double _startAngle = -math.pi / 2; // top (12 o'clock)
  static const double _sweep = 2 * math.pi / 6; // 6 axes

  late final AnimationController _animController;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Kick off the entrance animation
    if (_animController.isDismissed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 900;

    return AnimateOnVisible(
      builder: (context, visible) {
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          child: _buildContent(context, colorScheme, isCompact),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    bool isCompact,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -- Header ----------------------------------------------------------
        if (widget.title != null || widget.subtitle != null) ...[
          if (widget.title != null)
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: isCompact ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          if (widget.subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withAlpha(150),
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 32),
        ],

        // -- Radar + Labels (Stack) ------------------------------------------
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isCompact ? 380 : 540),
            child: SizedBox(
              height: isCompact ? 420 : 480,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = math.min(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );
                  return Center(
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Custom-painted radar (grid + colored spokes + polygon)
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: _anim,
                              builder: (context, _) => CustomPaint(
                                painter: _RadarPainter(
                                  axes: widget.axes,
                                  progress: _anim.value,
                                  textColor: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          // Horizontal labels around the chart
                          ..._buildLabels(size, colorScheme, isCompact),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // -- Generous spacing (prevents overlap with legends) ----------------
        const SizedBox(height: 50),

        // -- Tick Legend (independent) ----------------------------------------
        Center(child: _RadarTickLegend(labels: _tickLabels, isCompact: isCompact)),

        const SizedBox(height: 16),

        // -- Node Legend (independent, multi-color) ---------------------------
        Center(child: _RadarNodeLegend(axes: widget.axes, isCompact: isCompact)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Manual label positioning — always horizontal, never rotated.
  // ---------------------------------------------------------------------------

  List<Widget> _buildLabels(
    double chartSize,
    ColorScheme colorScheme,
    bool isCompact,
  ) {
    final center = chartSize / 2;
    final radius = chartSize * 0.44;
    final fontSize = isCompact ? 11.0 : 13.0;

    return List.generate(widget.axes.length, (i) {
      final angle = _startAngle + _sweep * i;
      final dx = center + radius * math.cos(angle);
      final dy = center + radius * math.sin(angle);
      final alignment = _labelAlignment(angle);

      return Positioned(
        left: dx,
        top: dy,
        child: FractionalTranslation(
          translation: const Offset(-0.5, -0.5),
          child: Align(
            alignment: alignment,
            child: SizedBox(
              width: isCompact ? 120 : 150,
              child: Text(
                widget.axes[i].label,
                textAlign: _textAlignFromAlignment(alignment),
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface.withAlpha(200),
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  static Alignment _labelAlignment(double angle) {
    final dx = math.cos(angle);
    final dy = math.sin(angle);
    const t = 0.4;

    if (dx.abs() < t) {
      return dy < 0 ? Alignment.bottomCenter : Alignment.topCenter;
    }
    if (dy.abs() < t) {
      return dx > 0 ? Alignment.centerLeft : Alignment.centerRight;
    }
    return Alignment(
      dx > 0 ? -1.0 : 1.0,
      dy < 0 ? 1.0 : -1.0,
    );
  }

  static TextAlign _textAlignFromAlignment(Alignment a) {
    if (a.x < -0.3) return TextAlign.right;
    if (a.x > 0.3) return TextAlign.left;
    return TextAlign.center;
  }
}

// ---------------------------------------------------------------------------
// CustomPainter — full control: grid, colored spokes, polygon, vertex dots
// ---------------------------------------------------------------------------

class _RadarPainter extends CustomPainter {
  final List<RadarAxis> axes;
  final double progress; // 0.0 → 1.0 for entrance animation
  final Color textColor;

  static const int _tickCount = 4;
  static const double _startAngle = -math.pi / 2;
  static const double _sweep = 2 * math.pi / 6;
  static const double _vertexRadius = 4.0;

  _RadarPainter({
    required this.axes,
    required this.progress,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2 * 0.72;

    _drawGrid(canvas, center, maxRadius);
    _drawColoredSpokes(canvas, center, maxRadius);
    _drawPolygon(canvas, center, maxRadius);
    _drawVertexDots(canvas, center, maxRadius);
  }

  // -- Grid: 4 concentric hexagonal rings ------------------------------------

  void _drawGrid(Canvas canvas, Offset center, double maxRadius) {
    final gridPaint = Paint()
      ..color = const Color(0xFF5C5C7A).withAlpha(180)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    for (int ring = 1; ring <= _tickCount; ring++) {
      final r = maxRadius * ring / _tickCount;
      final path = _hexagonPath(center, r);
      canvas.drawPath(path, gridPaint);
    }

    // Axis lines (thin, visible but not dominant)
    final axisPaint = Paint()
      ..color = const Color(0xFF5C5C7A).withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    for (int i = 0; i < axes.length; i++) {
      final angle = _startAngle + _sweep * i;
      final end = Offset(
        center.dx + maxRadius * math.cos(angle),
        center.dy + maxRadius * math.sin(angle),
      );
      canvas.drawLine(center, end, axisPaint);
    }
  }

  // -- Colored spokes: thin lines from center to each data point -------------

  void _drawColoredSpokes(Canvas canvas, Offset center, double maxRadius) {
    for (int i = 0; i < axes.length; i++) {
      final axis = axes[i];
      final angle = _startAngle + _sweep * i;
      final r = maxRadius * axis.value * progress;
      final end = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );

      final spokePaint = Paint()
        ..color = axis.color.withAlpha(120)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(center, end, spokePaint);
    }
  }

  // -- Polygon: filled shape connecting all data points ----------------------

  void _drawPolygon(Canvas canvas, Offset center, double maxRadius) {
    if (axes.isEmpty) return;

    final path = Path();
    for (int i = 0; i < axes.length; i++) {
      final angle = _startAngle + _sweep * i;
      final r = maxRadius * axes[i].value * progress;
      final point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();

    // Translucent fill
    final fillPaint = Paint()
      ..color = const Color(0xFF00D4FF).withAlpha(25)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Bright border
    final borderPaint = Paint()
      ..color = const Color(0xFF00D4FF).withAlpha(200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, borderPaint);
  }

  // -- Vertex dots: colored circles at each data point -----------------------

  void _drawVertexDots(Canvas canvas, Offset center, double maxRadius) {
    for (int i = 0; i < axes.length; i++) {
      final axis = axes[i];
      final angle = _startAngle + _sweep * i;
      final r = maxRadius * axis.value * progress;
      final point = Offset(
        center.dx + r * math.cos(angle),
        center.dy + r * math.sin(angle),
      );

      // Outer glow
      final glowPaint = Paint()
        ..color = axis.color.withAlpha(60)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, _vertexRadius + 3, glowPaint);

      // Solid dot
      final dotPaint = Paint()
        ..color = axis.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, _vertexRadius, dotPaint);

      // Bright center
      final centerDotPaint = Paint()
        ..color = Colors.white.withAlpha(200)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(point, 1.5, centerDotPaint);
    }
  }

  // -- Helper: hexagonal path -----------------------------------------------

  static Path _hexagonPath(Offset center, double radius) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = _startAngle + _sweep * i;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      progress != old.progress || axes != old.axes;
}

// ---------------------------------------------------------------------------
// Tick Legend — the 4 intensity levels shown below the chart
// ---------------------------------------------------------------------------

class _RadarTickLegend extends StatelessWidget {
  final List<String> labels;
  final bool isCompact;

  const _RadarTickLegend({
    required this.labels,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 20,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(labels.length, (i) {
        final alpha = 40 + (i * 55);
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00D4FF).withAlpha(alpha),
                border: Border.all(
                  color: const Color(0xFF00D4FF).withAlpha(alpha + 30),
                  width: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              labels[i],
              style: TextStyle(
                fontSize: isCompact ? 10 : 11,
                color: colorScheme.onSurface.withAlpha(160),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// Node Legend — axis names with their individual colors
// ---------------------------------------------------------------------------

class _RadarNodeLegend extends StatelessWidget {
  final List<RadarAxis> axes;
  final bool isCompact;

  const _RadarNodeLegend({
    required this.axes,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: axes.map((axis) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: axis.color,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              axis.label,
              style: TextStyle(
                fontSize: isCompact ? 10 : 11,
                color: colorScheme.onSurface.withAlpha(170),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
