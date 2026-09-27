import 'package:flutter/material.dart';

/// Soft fade + rise used across agency sites like Instrument.
/// Layout and paint stay identical — only opacity/transform animate in.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 850),
    this.offset = 36,
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.92,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offset;
  final Curve curve;

  /// Fraction of viewport height from the top. Animation starts when the
  /// widget's top edge crosses this line (Instrument-like ~85–92%).
  final double threshold;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  ScrollPosition? _position;
  bool _started = false;
  bool _scheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _opacity = curved;
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(curved);

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position == _position) return;
    _position?.removeListener(_checkVisibility);
    _position = position;
    _position?.addListener(_checkVisibility);
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_started || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final view = View.of(context);
    final screenHeight = view.physicalSize.height / view.devicePixelRatio;
    final top = renderObject.localToGlobal(Offset.zero).dy;

    // Already above the fold, or scrolled into the trigger band.
    if (top < screenHeight * widget.threshold) {
      _started = true;
      _scheduleForward();
    }
  }

  void _scheduleForward() {
    if (_scheduled) return;
    _scheduled = true;
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _slide.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
