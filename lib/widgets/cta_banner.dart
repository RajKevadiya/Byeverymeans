import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_buttons.dart';
import 'reveal.dart';

class CtaBanner extends StatelessWidget {
  const CtaBanner({super.key, required this.title, required this.subtitle, required this.onPressed});

  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 768;

    return Reveal(
      child: Container(
        width: double.infinity,
        color: AppColors.orange,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: wide ? 96 : 72),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: wide ? 48 : 36,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.8,
                  color: Colors.white,
                  height: 1.15,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 40),
            WhiteButton(label: 'Contact Us →', onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
