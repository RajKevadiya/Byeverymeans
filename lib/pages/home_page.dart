import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_buttons.dart';
import '../widgets/content_padding.dart';
import '../widgets/cta_banner.dart';
import '../widgets/reveal.dart';
import '../widgets/section_label.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Hero(onNavigate: onNavigate),
        const _DarkBanner(),
        _FeaturedProjects(onNavigate: onNavigate),
        CtaBanner(
          title: 'Ready to build something impossible to ignore?',
          subtitle: "Let's talk about your project and see if we're a good fit. No pressure, just a conversation.",
          onPressed: () => onNavigate(AppPage.contact),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isLg(context);
    final md = Breakpoints.isMd(context);

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: md ? 72 : 48,
              fontWeight: FontWeight.w500,
              height: 1.05,
              letterSpacing: -2.5,
              color: AppColors.dark,
            ),
            children: const [
              TextSpan(text: 'We don\'t judge a\n'),
              TextSpan(text: 'business by it\'s size we judge it by it\'s '),
              TextSpan(
                text: 'ambition',
                style: TextStyle(color: AppColors.orange),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 40),
        // ConstrainedBox(
        //   constraints: const BoxConstraints(maxWidth: 560),
        //   child: Text(
        //     'We believe every ambitious business deserves the opportunity to stand out. From brand strategy to digital experience, we partner with you to create work that matters.',
        //     style: TextStyle(
        //       fontSize: md ? 22 : 18,
        //       fontWeight: FontWeight.w300,
        //       color: AppColors.gray600,
        //       height: 1.4,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            OrangeButton(label: 'Our Services', onPressed: () => onNavigate(AppPage.services)),
            OutlineButton(label: 'Our Work', onPressed: () => onNavigate(AppPage.work)),
          ],
        ),
      ],
    );

    final graphic = const AspectRatio(
      aspectRatio: 1,
      child: _AnimatedSelectionArrow(),
    );

    return ContentPadding(
      vertical: wide ? 96 : 72,
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Reveal(child: copy),
                ),
                const SizedBox(width: 64),
                SizedBox(
                  width: 360,
                  child: Reveal(
                    delay: const Duration(milliseconds: 140),
                    child: graphic,
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Reveal(child: copy),
                const SizedBox(height: 48),
                Reveal(
                  delay: const Duration(milliseconds: 120),
                  child: graphic,
                ),
              ],
            ),
    );
  }
}

class _AnimatedSelectionArrow extends StatefulWidget {
  const _AnimatedSelectionArrow();

  @override
  State<_AnimatedSelectionArrow> createState() => _AnimatedSelectionArrowState();
}

class _AnimatedSelectionArrowState extends State<_AnimatedSelectionArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _SelectionArrowPainter(t: _controller.value),
        );
      },
    );
  }
}

class _SelectionArrowPainter extends CustomPainter {
  _SelectionArrowPainter({required this.t});

  final double t;

  static const _color = AppColors.orange;

  // Click corner = the vertex made of two straight sides (not on the dented edge).
  static const _localTip = Offset(0, -64);
  static const _pathUnit = 128.0;

  @override
  void paint(Canvas canvas, Size size) {
    final s = math.min(size.width, size.height);
    final pose = _poseAt(t);
    final prevT = (t - 0.02 + 1.0) % 1.0;
    final prev = _poseAt(prevT);

    var velocity = Offset(pose.x - prev.x, pose.y - prev.y);
    // Ignore the loop wrap discontinuity.
    if (velocity.distance > 0.35) velocity = Offset.zero;
    final speed = velocity.distance;
    final blurStrength = (speed * 22).clamp(0.0, 1.0);

    final center = Offset(size.width * pose.x, size.height * pose.y);
    final arrowSize = s * 0.92 * pose.scale;
    final dir = speed > 0.0001 ? velocity / speed : Offset.zero;
    final stretchAxis = dir == Offset.zero ? const Offset(-1, -1) : dir;
    final primaryStretch = 1.0 + blurStrength * 0.18;

    final tip = _tipWorld(
      center: center,
      size: arrowSize,
      rotation: pose.rotation,
      localTip: _localTip,
      stretch: primaryStretch,
      stretchAxis: stretchAxis,
    );

    final glowPaint = Paint()
      ..color = _color.withValues(alpha: 0.09 + blurStrength * 0.1)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, s * 0.09);
    canvas.drawCircle(
      Offset.lerp(center, tip, 0.35)!,
      arrowSize * 0.58,
      glowPaint,
    );

    // Motion-blur ghosts trailing opposite to travel direction.
    if (blurStrength > 0.03) {
      const ghosts = 9;
      for (var i = ghosts; i >= 1; i--) {
        final falloff = i / ghosts;
        final trail = dir * (-arrowSize * 0.72 * blurStrength * falloff);
        final stretch = 1.0 + blurStrength * 0.7 * falloff;
        final alpha = (0.09 * (1.0 - falloff) + 0.05 * blurStrength).clamp(0.0, 0.28);
        _drawArrow(
          canvas,
          origin: center + trail,
          size: arrowSize,
          rotation: pose.rotation,
          press: pose.press,
          pressPivot: _localTip,
          stretch: stretch,
          stretchAxis: stretchAxis,
          color: _color.withValues(alpha: alpha),
          blurSigma: arrowSize * 0.055 * blurStrength * falloff,
        );
      }
    }

    // Primary crisp arrow.
    _drawArrow(
      canvas,
      origin: center,
      size: arrowSize,
      rotation: pose.rotation,
      press: pose.press,
      pressPivot: _localTip,
      stretch: primaryStretch,
      stretchAxis: stretchAxis,
      color: _color,
      blurSigma: blurStrength > 0.15 ? arrowSize * 0.018 * blurStrength : 0,
    );

    // Click ripples at the cursor tip.
    if (pose.ripple > 0) {
      for (final layer in [0.0, 0.28, 0.55]) {
        final progress = ((pose.ripple - layer) / (1.0 - layer)).clamp(0.0, 1.0);
        if (progress <= 0) continue;
        final radius = arrowSize * (0.14 + progress * 0.78);
        final alpha = (1.0 - progress) * 0.42;
        final stroke = Paint()
          ..color = _color.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = arrowSize * (0.05 * (1.0 - progress * 0.55));
        canvas.drawCircle(tip, radius, stroke);

        if (layer == 0.0 && progress < 0.4) {
          final fill = Paint()..color = _color.withValues(alpha: (0.4 - progress) * 0.65);
          canvas.drawCircle(tip, arrowSize * 0.1 * (1.0 - progress / 0.4), fill);
        }
      }
    }
  }

  void _drawArrow(
    Canvas canvas, {
    required Offset origin,
    required double size,
    required double rotation,
    required double press,
    required Offset pressPivot,
    required double stretch,
    required Offset stretchAxis,
    required Color color,
    required double blurSigma,
  }) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.rotate(rotation);

    if ((stretch - 1).abs() > 0.01 && stretchAxis != Offset.zero) {
      final angle = math.atan2(stretchAxis.dy, stretchAxis.dx) - rotation;
      canvas.rotate(angle);
      canvas.scale(stretch, 1 / math.sqrt(stretch));
      canvas.rotate(-angle);
    }

    // Press compresses toward the click corner so it stays planted under the ripple.
    final pivot = pressPivot * (size / _pathUnit);
    final pressScale = 1.0 - press * 0.14;
    canvas.translate(pivot.dx, pivot.dy);
    canvas.scale(pressScale, pressScale);
    canvas.translate(-pivot.dx, -pivot.dy);

    final path = _arrowPath(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    if (blurSigma > 0.5) {
      paint.maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    }
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  /// Pixel-exact arrow from the reference image, oriented so the click corner
  /// (two straight sides — not on the dented edge) points up.
  ///
  /// Source corners: TL (both straight) · TIP & BL (share the dented side) · NOTCH.
  Path _arrowPath(double size) {
    final k = size / _pathUnit;
    return Path()
      ..moveTo(0 * k, -64 * k) // TL — both straight sides (ripple / click)
      ..lineTo(128 * k, 27 * k) // former tip (on dented side)
      ..lineTo(54 * k, 40 * k) // notch (dent)
      ..lineTo(0 * k, 88 * k) // BL (on dented side)
      ..close();
  }

  /// World-space position for a local corner on the arrow.
  Offset _tipWorld({
    required Offset center,
    required double size,
    required double rotation,
    required Offset localTip,
    required double stretch,
    required Offset stretchAxis,
  }) {
    var local = localTip * (size / _pathUnit);

    // Same directional stretch applied around the origin as in _drawArrow.
    if ((stretch - 1).abs() > 0.01 && stretchAxis != Offset.zero) {
      final axisAngle = math.atan2(stretchAxis.dy, stretchAxis.dx) - rotation;
      final c = math.cos(-axisAngle);
      final s = math.sin(-axisAngle);
      var p = Offset(local.dx * c - local.dy * s, local.dx * s + local.dy * c);
      p = Offset(p.dx * stretch, p.dy / math.sqrt(stretch));
      final c2 = math.cos(axisAngle);
      final s2 = math.sin(axisAngle);
      local = Offset(p.dx * c2 - p.dy * s2, p.dx * s2 + p.dy * c2);
    }

    final c = math.cos(rotation);
    final s = math.sin(rotation);
    final rotated = Offset(local.dx * c - local.dy * s, local.dx * s + local.dy * c);
    return center + rotated;
  }

  _ArrowPose _poseAt(double t) {
    // dash in → click → dash → click → whip home
    late Offset pos;
    late double rot;
    late double scale;
    var press = 0.0;
    var ripple = 0.0;

    if (t < 0.20) {
      final e = Curves.easeOutCubic.transform(_segment(t, 0.00, 0.20));
      pos = Offset.lerp(const Offset(0.84, 0.82), const Offset(0.56, 0.54), e)!;
      rot = _lerp(-0.95, -0.55, e);
      scale = _lerp(0.7, 1.0, e);
    } else if (t < 0.36) {
      pos = const Offset(0.56, 0.54);
      rot = -0.55;
      scale = 1.0;
      final click = _segment(t, 0.20, 0.36);
      press = _pressEnvelope(click);
      ripple = Curves.easeOut.transform(click);
    } else if (t < 0.54) {
      final e = Curves.easeInOutCubic.transform(_segment(t, 0.36, 0.54));
      pos = Offset.lerp(const Offset(0.56, 0.54), const Offset(0.28, 0.30), e)!;
      rot = _lerp(-0.55, -0.28, e);
      final mid = (e < 0.5) ? e * 2 : (1 - e) * 2;
      scale = 1.0 - mid * 0.1;
    } else if (t < 0.70) {
      pos = const Offset(0.28, 0.30);
      rot = -0.28;
      scale = 1.0;
      final click = _segment(t, 0.54, 0.70);
      press = _pressEnvelope(click);
      ripple = Curves.easeOut.transform(click);
    } else {
      final e = Curves.easeInOutCubic.transform(_segment(t, 0.70, 1.00));
      final drift = math.sin(e * math.pi);
      final base = Offset.lerp(const Offset(0.28, 0.30), const Offset(0.84, 0.82), e)!;
      pos = Offset(base.dx - drift * 0.05, base.dy - drift * 0.08);
      rot = _lerp(-0.28, -0.95, e);
      scale = 1.0;
    }

    final float = math.sin(t * math.pi * 2) * 0.01;
    pos = Offset(pos.dx, pos.dy + float);

    return _ArrowPose(
      x: pos.dx,
      y: pos.dy,
      rotation: rot,
      scale: scale,
      press: press,
      ripple: ripple,
    );
  }

  double _pressEnvelope(double localT) {
    if (localT < 0.28) return Curves.easeOut.transform(localT / 0.28);
    if (localT < 0.55) return 1.0 - Curves.easeIn.transform((localT - 0.28) / 0.27);
    return 0;
  }

  double _segment(double t, double a, double b) => ((t - a) / (b - a)).clamp(0.0, 1.0);

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(covariant _SelectionArrowPainter oldDelegate) => oldDelegate.t != t;
}

class _ArrowPose {
  const _ArrowPose({
    required this.x,
    required this.y,
    required this.rotation,
    required this.scale,
    required this.press,
    required this.ripple,
  });

  final double x;
  final double y;
  final double rotation;
  final double scale;
  final double press;
  final double ripple;
}

class _DarkBanner extends StatelessWidget {
  const _DarkBanner();

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

    return Reveal(
      child: Container(
        width: double.infinity,

        // margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: wide ? 100 : 80),
        child: ContentPadding(
          child: Column(
            children: [
              const SectionLabel('Our Philosophy', color: AppColors.gray400, fontSize: 18),
              const SizedBox(height: 32),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: wide ? 48 : 36,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.8,
                    color: AppColors.dark,
                    height: 1.2,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Every ambitious business  ',
                      style: TextStyle(color: AppColors.orange),
                    ),
                    TextSpan(text: 'deserves\nthe opportunity to stand out'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: 32),
              // ConstrainedBox(
              //   constraints: const BoxConstraints(maxWidth: 560),
              //   child: Text(
              //     "A brand is more than a logo. It's a feeling, a promise, and a strategic asset that drives growth.",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: AppColors.gray400, height: 1.5),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedProjects extends StatelessWidget {
  const _FeaturedProjects({required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  static const _projects = [
    ('M', 'Meridian', 'Brand Identity & Digital Platform'),
    ('N', 'Nexus', 'Digital Product + UX/UI'),
    ('F', 'Forma', 'E-commerce & Packaging'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

    return ContentPadding(
      vertical: wide ? 128 : 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Work',
                        style: TextStyle(fontSize: wide ? 48 : 36, fontWeight: FontWeight.w500, letterSpacing: -0.6),
                      ),
                    ],
                  ),
                ),
                if (wide) TextLinkButton(label: 'View all work →', onPressed: () => onNavigate(AppPage.work)),
              ],
            ),
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final count = wide ? 3 : 1;
              final gap = 24.0;
              final itemWidth = (constraints.maxWidth - gap * (count - 1)) / count;

              return Wrap(
                spacing: gap,
                runSpacing: 40,
                children: [
                  for (var i = 0; i < _projects.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: Reveal(
                        delay: Duration(milliseconds: i * 100),
                        child: InkWell(
                          onTap: () => onNavigate(AppPage.work),
                          borderRadius: BorderRadius.circular(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _projects[i].$1,
                                    style: TextStyle(
                                      fontSize: 96,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic,
                                      color: AppColors.border,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(_projects[i].$2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 8),
                              Text(
                                _projects[i].$3,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.gray500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          if (!wide) ...[
            const SizedBox(height: 32),
            Reveal(
              child: TextLinkButton(label: 'View all work →', onPressed: () => onNavigate(AppPage.work)),
            ),
          ],
        ],
      ),
    );
  }
}
