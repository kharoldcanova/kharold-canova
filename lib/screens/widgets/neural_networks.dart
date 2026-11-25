import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kharoldcanova/config/theme/brand_theme.dart';
import 'package:kharoldcanova/config/theme/portfolio_tokens.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';

/// Below this canvas width the networks stack in rows instead of columns.
const double kNeuralStackWidth = 420;

/// Hero signature (DESIGN.md 3.2): three small networks, one per project
/// family, that wake up under the pointer or a tap. The ticker only runs
/// while something is moving, so an idle page costs no frames.
class NeuralNetworksPanel extends StatelessWidget {
  const NeuralNetworksPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;

    return Container(
      key: const Key('hero-networks'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: tokens.elevated.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(BrandTheme.radiusLG),
        border: Border.all(color: tokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BrandTheme.spaceMD,
              vertical: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    t.nn_title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                  ),
                ),
                Text(
                  t.nn_hint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: tokens.borderSubtle),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < kNeuralStackWidth;
              return SizedBox(
                height: stacked ? 480 : 300,
                child: NeuralNetworks(
                  networks: [
                    NeuralNetSpec(
                      name: t.nn_vision,
                      caption: 'LAIN · MiniCPM-V',
                      layers: const [5, 7, 7, 3],
                    ),
                    NeuralNetSpec(
                      name: t.nn_voice,
                      caption: 'LAIN · Kokoro',
                      layers: const [4, 6, 6, 6, 4],
                    ),
                    NeuralNetSpec(
                      name: t.nn_sql,
                      caption: 'ia-sql · Ollama',
                      layers: const [6, 5, 5, 6],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

@immutable
class NeuralNetSpec {
  const NeuralNetSpec({
    required this.name,
    required this.caption,
    required this.layers,
  });

  final String name;
  final String caption;
  final List<int> layers;
}

class NeuralNetworks extends StatefulWidget {
  const NeuralNetworks({super.key, required this.networks});

  final List<NeuralNetSpec> networks;

  @override
  State<NeuralNetworks> createState() => _NeuralNetworksState();
}

class _Node {
  _Node(this.hx, this.hy)
      : x = hx,
        y = hy;
  double hx, hy, x, y;
  double a = 0;
}

class _Pulse {
  _Pulse(this.layer, this.from, this.to);
  final int layer;
  final int from;
  final int to;
  double t = 0;
}

class _Net {
  _Net(this.spec);
  final NeuralNetSpec spec;
  Rect box = Rect.zero;
  List<List<_Node>> nodes = const [];
  final List<_Pulse> pulses = [];
  double heat = 0;
}

class _NeuralNetworksState extends State<NeuralNetworks>
    with SingleTickerProviderStateMixin {
  static const _introSeconds = 2.5;
  static const _maxPulses = 260;

  final _random = math.Random(7);
  final _repaint = ValueNotifier<int>(0);
  late final Ticker _ticker = createTicker(_onTick);
  late List<_Net> _nets;
  Size _size = Size.zero;
  Offset? _pointer;
  Duration _last = Duration.zero;
  double _clock = 0;

  bool get _reduceMotion => MediaQuery.disableAnimationsOf(context);

  @override
  void initState() {
    super.initState();
    _nets = [for (final spec in widget.networks) _Net(spec)];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // A short intro shows the networks are alive, then they rest.
    if (!_reduceMotion && _clock == 0) _wake();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _repaint.dispose();
    super.dispose();
  }

  void _wake() {
    if (_reduceMotion) {
      _repaint.value++;
      return;
    }
    if (!_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    }
  }

  void _layout(Size size) {
    if (size == _size) return;
    _size = size;
    final stacked = size.width < kNeuralStackWidth;
    final count = _nets.length;
    for (var i = 0; i < count; i++) {
      final net = _nets[i];
      final box = stacked
          ? Rect.fromLTWH(18, i * size.height / count + 12, size.width - 36,
              size.height / count - 64)
          : Rect.fromLTWH(i * size.width / count + 18, 20,
              size.width / count - 36, size.height - 66);
      net.box = box;
      final layers = net.spec.layers;
      net.nodes = [
        for (var l = 0; l < layers.length; l++)
          [
            for (var k = 0; k < layers[l]; k++)
              _Node(
                box.left + box.width * (l / (layers.length - 1)),
                box.top + box.height * ((k + 1) / (layers[l] + 1)),
              ),
          ],
      ];
      net.pulses.clear();
    }
  }

  void _fire(_Net net, int layer, int node) {
    if (layer >= net.nodes.length - 1) return;
    final fan = net.heat > 0.3 ? 2 : 1;
    for (var f = 0; f < fan; f++) {
      net.pulses.add(
          _Pulse(layer, node, _random.nextInt(net.nodes[layer + 1].length)));
    }
  }

  bool _inside(_Net net) {
    final p = _pointer;
    return p != null && net.box.inflate(14).contains(p);
  }

  void _onTick(Duration elapsed) {
    final dt = ((elapsed - _last).inMicroseconds / 1e6).clamp(0.0, 0.05);
    _last = elapsed;
    _clock += dt;
    final f = dt * 60; // simulation tuned in 60 fps frames
    final intro = _clock < _introSeconds;
    var busy = intro;

    for (final net in _nets) {
      if (net.nodes.isEmpty) continue;
      final inside = _inside(net);
      net.heat += ((inside ? 1 : 0) - net.heat) * (1 - math.pow(0.92, f));
      final rate = (intro ? 0.1 : 0) + net.heat * 0.35;
      if (_random.nextDouble() < rate * f) {
        _fire(net, 0, _random.nextInt(net.nodes.first.length));
      }

      final decay = math.pow(0.94, f).toDouble();
      final ease = 1 - math.pow(0.85, f).toDouble();
      for (final layer in net.nodes) {
        for (final n in layer) {
          var tx = n.hx, ty = n.hy;
          final p = _pointer;
          if (inside && p != null) {
            final dx = p.dx - n.hx, dy = p.dy - n.hy;
            final d = math.sqrt(dx * dx + dy * dy);
            if (d < 90) {
              final pull = 0.18 * (1 - d / 90);
              tx += dx * pull;
              ty += dy * pull;
              n.a = math.max(n.a, 0.6 * (1 - d / 90));
            }
          }
          n.x += (tx - n.x) * ease;
          n.y += (ty - n.y) * ease;
          n.a *= decay;
          if (n.a > 0.02 ||
              (n.x - n.hx).abs() > 0.3 ||
              (n.y - n.hy).abs() > 0.3) {
            busy = true;
          }
        }
      }

      final speed = (0.035 + net.heat * 0.03) * f;
      // Arrivals fire the next layer after the sweep, never while iterating.
      final arrived = <_Pulse>[];
      net.pulses.removeWhere((pulse) {
        pulse.t += speed;
        if (pulse.t < 1) return false;
        arrived.add(pulse);
        return true;
      });
      for (final pulse in arrived) {
        net.nodes[pulse.layer + 1][pulse.to].a = 1;
        _fire(net, pulse.layer + 1, pulse.to);
      }
      if (net.pulses.length > _maxPulses) {
        net.pulses.removeRange(0, net.pulses.length - _maxPulses);
      }
      if (net.pulses.isNotEmpty || inside || net.heat > 0.01) busy = true;
    }

    _repaint.value++;
    if (!busy) _ticker.stop();
  }

  /// A tap lights the touched network and sends a burst through it, so a
  /// quick touch on a phone is visible even after the finger lifts.
  void _burst(Offset position) {
    for (final net in _nets) {
      if (net.nodes.isEmpty || !net.box.inflate(14).contains(position)) {
        continue;
      }
      net.heat = 1;
      for (var k = 0; k < net.nodes.first.length; k++) {
        net.nodes.first[k].a = 1;
        _fire(net, 0, k);
      }
    }
    _wake();
  }

  void _setPointer(Offset? position) {
    _pointer = position;
    if (_reduceMotion) {
      for (final net in _nets) {
        net.heat = _inside(net) ? 1 : 0;
      }
    }
    _wake();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final tokens = Theme.of(context).extension<PortfolioTokens>()!;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: t.nn_semantics,
      image: true,
      child: MouseRegion(
        onHover: (e) => _setPointer(e.localPosition),
        onExit: (_) => _setPointer(null),
        child: Listener(
          onPointerDown: (e) {
            if (!_reduceMotion) _burst(e.localPosition);
            _setPointer(e.localPosition);
          },
          onPointerMove: (e) {
            if (e.kind != PointerDeviceKind.mouse) _setPointer(e.localPosition);
          },
          // A finger lifting is the touch equivalent of the mouse leaving.
          onPointerUp: (e) {
            if (e.kind != PointerDeviceKind.mouse) _setPointer(null);
          },
          onPointerCancel: (_) => _setPointer(null),
          child: LayoutBuilder(
            builder: (context, constraints) {
              _layout(constraints.biggest);
              return CustomPaint(
                size: constraints.biggest,
                painter: _NeuralPainter(
                  nets: _nets,
                  repaint: _repaint,
                  accent: colorScheme.primary,
                  muted: colorScheme.onSurfaceVariant,
                  ink: colorScheme.onSurface,
                  ground: colorScheme.surface,
                  edgeIdle: tokens.borderSubtle,
                  labelStyle: textTheme.bodySmall ?? const TextStyle(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NeuralPainter extends CustomPainter {
  _NeuralPainter({
    required this.nets,
    required Listenable repaint,
    required this.accent,
    required this.muted,
    required this.ink,
    required this.ground,
    required this.edgeIdle,
    required this.labelStyle,
  }) : super(repaint: repaint);

  final List<_Net> nets;
  final Color accent, muted, ink, ground, edgeIdle;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final fill = Paint();

    for (final net in nets) {
      if (net.nodes.isEmpty) continue;
      final heat = net.heat;

      final path = Path();
      for (var l = 0; l < net.nodes.length - 1; l++) {
        for (final a in net.nodes[l]) {
          for (final b in net.nodes[l + 1]) {
            path
              ..moveTo(a.x, a.y)
              ..lineTo(b.x, b.y);
          }
        }
      }
      edge.color = Color.lerp(edgeIdle, accent.withValues(alpha: 0.3), heat)!;
      canvas.drawPath(path, edge);

      fill.color = accent.withValues(alpha: 0.9);
      for (final p in net.pulses) {
        final a = net.nodes[p.layer][p.from];
        final b = net.nodes[p.layer + 1][p.to];
        canvas.drawCircle(
          Offset(a.x + (b.x - a.x) * p.t, a.y + (b.y - a.y) * p.t),
          2.2,
          fill,
        );
      }

      for (final layer in net.nodes) {
        for (final n in layer) {
          final c = Offset(n.x, n.y);
          fill.color = ground;
          canvas.drawCircle(c, 4.5, fill);
          final lit = n.a > 0.05 || heat > 0.05;
          fill.color =
              (lit ? accent : muted).withValues(alpha: 0.25 + n.a * 0.75);
          canvas.drawCircle(c, 4.5, fill);
          if (n.a > 0.2) {
            fill.color = accent.withValues(alpha: n.a * 0.25);
            canvas.drawCircle(c, 4.5 + n.a * 7, fill);
          }
        }
      }

      final cx = net.box.center.dx;
      _label(
        canvas,
        net.spec.name,
        labelStyle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color.lerp(ink.withValues(alpha: 0.6), accent, heat),
        ),
        Offset(cx, net.box.bottom + 12),
      );
      _label(
        canvas,
        net.spec.caption,
        labelStyle.copyWith(
          fontSize: 11.5,
          color: muted.withValues(alpha: 0.55 + heat * 0.45),
        ),
        Offset(cx, net.box.bottom + 29),
      );
    }
  }

  void _label(Canvas canvas, String text, TextStyle style, Offset topCenter) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: 220);
    tp.paint(canvas, topCenter - Offset(tp.width / 2, 0));
    tp.dispose();
  }

  @override
  bool shouldRepaint(_NeuralPainter old) =>
      old.accent != accent ||
      old.muted != muted ||
      old.ink != ink ||
      old.ground != ground ||
      old.edgeIdle != edgeIdle ||
      old.nets != nets;
}
