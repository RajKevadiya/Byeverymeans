import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_padding.dart';
import '../widgets/cta_banner.dart';
import '../widgets/outcome_grid.dart';
import '../widgets/reveal.dart';
import '../widgets/section_label.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key, required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  static const _services = [
    (
      '01',
      'Brand Strategy',
      'Positioning, naming, messaging architecture, and brand narrative. We capture your essence and connect with your audience.',
    ),
    (
      '02',
      'Brand Identity',
      'Logos, color systems, typography, visual direction, and comprehensive guidelines that create a distinctive visual language.',
    ),
    (
      '03',
      'Campaigns',
      'Integrated marketing campaigns across multiple touchpoints to drive awareness and fuel engagement.',
    ),
    (
      '04',
      'Digital Experiences',
      'Web design, UI/UX, and digital products designed for the user. From marketing sites to complex platforms and design systems.',
    ),
    (
      '05',
      'Print & Packaging',
      'Print campaigns, packaging, layouts, and physical brand touchpoints to ground your brand in the physical world.',
    ),
    (
      '06',
      'Brand Systems',
      'Comprehensive roll-outs and governance for a unified, scalable system that keeps your brand consistent everywhere.',
    ),
  ];

  static const _approaches = [
    (
      Icons.bolt_outlined,
      'Strategy-led',
      'Every decision begins with deep understanding — of your business, your market, and your people.',
    ),
    (
      Icons.image_outlined,
      'Design-driven',
      'We believe in aesthetics, utility, and joy. Every visual and interaction matters in the pursuit of quality.',
    ),
    (
      Icons.favorite_border,
      'Meaning-focused',
      "We don't just make things look good. We build brands that resonate, connect, and create lasting value.",
    ),
  ];

  static const _outcomes = [
    OutcomeItem(number: '01', title: 'Clarity', description: 'Focusing your strategy & vision'),
    OutcomeItem(number: '02', title: 'Recognition', description: 'Standing out instantly'),
    OutcomeItem(number: '03', title: 'Consistency', description: 'Cohesive touchpoints'),
    OutcomeItem(number: '04', title: 'Trust', description: 'Building credibility fast'),
    OutcomeItem(number: '05', title: 'Growth', description: 'Driving measurable results'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);
    final lg = Breakpoints.isLg(context);

    return Column(
      children: [
        ContentPadding(
          vertical: wide ? 96 : 72,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Reveal(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: wide ? 56 : 36,
                          fontWeight: FontWeight.w500,
                          height: 1.05,
                          letterSpacing: -1,
                        ),
                        children: const [
                          TextSpan(
                            text:
                                "We believe every problem has more than one solution. Our job is to find the one that moves your business forward.\t",
                          ),
                          TextSpan(
                            text: 'By Every Means. ',
                            style: TextStyle(color: AppColors.orange),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 96),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              const Reveal(child: Center(child: SectionLabel('Our Services', fontSize: 18))),
              const SizedBox(height: 25),
              LayoutBuilder(
                builder: (context, constraints) {
                  final count = lg ? 3 : (wide ? 2 : 1);
                  final gap = 24.0;
                  final itemWidth = (constraints.maxWidth - gap * (count - 1)) / count;

                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < _services.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: Reveal(
                            delay: Duration(milliseconds: (i % count) * 90),
                            child: Container(
                              padding: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _services[i].$1,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.orange),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    _services[i].$2,
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: -0.4),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _services[i].$3,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.gray600,
                                      height: 1.6,
                                    ),
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
              const SizedBox(height: 96),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              const Reveal(child: Center(child: SectionLabel('Our Approach', fontSize: 18))),
              const SizedBox(height: 25),
              LayoutBuilder(
                builder: (context, constraints) {
                  final count = wide ? 3 : 1;
                  final gap = 48.0;
                  final itemWidth = (constraints.maxWidth - gap * (count - 1)) / count;

                  return Wrap(
                    spacing: gap,
                    runSpacing: 48,
                    children: [
                      for (var i = 0; i < _approaches.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: Reveal(
                            delay: Duration(milliseconds: i * 100),
                            child: Column(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Icon(_approaches[i].$1, color: AppColors.orange),
                                ),
                                const SizedBox(height: 24),
                                Text(_approaches[i].$2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    _approaches[i].$3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.gray600,
                                      height: 1.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 96),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              const Reveal(child: Center(child: SectionLabel('What You Gain', fontSize: 18))),
              const SizedBox(height: 25),
              const OutcomeGrid(items: _outcomes),
            ],
          ),
        ),
        CtaBanner(
          title: "Let's build something remarkable together",
          subtitle: "Tell us about your project and we'll figure out the best approach together.",
          onPressed: () => onNavigate(AppPage.contact),
        ),
      ],
    );
  }
}
