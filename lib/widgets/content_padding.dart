import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ContentPadding extends StatelessWidget {
  const ContentPadding({super.key, required this.child, this.vertical = 0});

  final Widget child;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: wide ? 48 : 24,
            vertical: vertical,
          ),
          child: child,
        ),
      ),
    );
  }
}
