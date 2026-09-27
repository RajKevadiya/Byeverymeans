import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_padding.dart';
import '../widgets/cta_banner.dart';
import '../widgets/reveal.dart';
import '../widgets/section_label.dart';

class ProcessPage extends StatelessWidget {
  const ProcessPage({super.key, required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  static const _practices = [
    (Icons.check, 'Mutual engagement', 'Both teams invest deeply.'),
    (Icons.schedule, 'Milestone-driven', 'Clear checkpoints and reviews.'),
    (Icons.chat_bubble_outline, 'Collaborative', 'Your input is critical at all stages.'),
  ];

  static const _steps = [
    (
      '01',
      'Discover',
      'An immersive analysis into your business, your audience, and competitive landscape. We uncover the insights that will guide everything that follows.',
      ['Brand Audit', 'Market Research', 'Audience Insights'],
      false,
    ),
    (
      '02',
      'Define',
      'We turn our research into a clear creative direction. Strategy meets intuition to align on the core narrative that will drive the visual output.',
      ['Creative Direction', 'Moodboards'],
      true,
    ),
    (
      '03',
      'Design',
      'We bring the strategy to life. Through iterative design and regular collaboration, we refine every detail until it feels right — from logos to layouts.',
      ['Logo & Identity', 'Prototypes', 'Design System'],
      false,
    ),
    (
      '04',
      'Develop',
      'If digital, here is where code gets written. Pixel-perfect translation from design to screen, ensuring robust performance and flawless interactions.',
      ['Web Development', 'CMS Setup'],
      true,
    ),
    (
      '05',
      'Deliver',
      'We handle the final production, deployment and handoff. You receive comprehensive assets, guidelines and support you need to succeed.',
      ['Final Assets', 'Brand Guidelines', 'Launch Support'],
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

    return Column(
      children: [
        ContentPadding(
          vertical: wide ? 96 : 72,
          child: Column(
            children: [
              Reveal(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: wide ? 56 : 36,
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                        letterSpacing: -1,
                      ),
                      children: const [
                        TextSpan(text: 'Every great brand begins with '),
                        TextSpan(
                          text: 'understanding',
                          style: TextStyle(color: AppColors.orange),
                        ),
                        TextSpan(text: ' before execution'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              /* const SizedBox(height: 32),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(
                  'A transparent, collaborative approach that takes your project from idea to impact. We believe great work comes from a great process.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: AppColors.gray600, height: 1.5),
                ),
              ),
              const SizedBox(height: 96),
              Container(
                padding: EdgeInsets.all(wide ? 40 : 28),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppColors.border),
                ),
                child: Builder(
                  builder: (context) {
                    final left = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Structure creates freedom',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, letterSpacing: -0.6),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Rules give us a shared language and clarity — freeing up the creative mind to explore and build safely without getting lost. By establishing how we work together from the start, we remove guesswork, align expectations, and create space for the best ideas to emerge.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: AppColors.gray600,
                            height: 1.6,
                          ),
                        ),
                      ],
                    );

                    final right = Column(
                      children: _practices.map((p) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.orange.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(p.$1, size: 16, color: AppColors.orange),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(p.$2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 4),
                                      Text(
                                        p.$3,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: AppColors.gray500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );

                    if (wide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: left),
                          const SizedBox(width: 48),
                          Expanded(child: right),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [left, const SizedBox(height: 32), right],
                    );
                  },
                ),
              ),
              const SizedBox(height: 96),*/
              const SizedBox(height: 96),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              const Reveal(child: Center(child: SectionLabel('The Process', fontSize: 18))),
              const SizedBox(height: 25),
              // Text('The Journey', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, letterSpacing: -0.5)),
              // const SizedBox(height: 64),
              ..._steps.map(
                (step) => Reveal(
                  child: _TimelineStep(
                    number: step.$1,
                    title: step.$2,
                    body: step.$3,
                    tags: step.$4,
                    reverse: step.$5,
                    wide: wide,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              Builder(
                builder: (context) {
                  Widget card(String label) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1),
                        ),
                      ),
                    );
                  }

                  const labels = ['Transparent Communication', 'Collaborative Thinking', 'Continuous Refinement'];

                  if (wide) {
                    return Row(
                      spacing: 15,
                      children: [
                        for (var i = 0; i < labels.length; i++)
                          Expanded(
                            child: Reveal(
                              delay: Duration(milliseconds: i * 90),
                              child: card(labels[i]),
                            ),
                          ),
                      ],
                    );
                  }

                  return Column(
                    spacing: 15,
                    children: [
                      for (var i = 0; i < labels.length; i++)
                        Reveal(
                          delay: Duration(milliseconds: i * 90),
                          child: card(labels[i]),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        CtaBanner(
          title: "Let's build something with clarity and purpose",
          subtitle: "Every great project starts with a conversation. Let's talk about what you need.",
          onPressed: () => onNavigate(AppPage.contact),
        ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.number,
    required this.title,
    required this.body,
    required this.tags,
    required this.reverse,
    required this.wide,
  });

  final String number;
  final String title;
  final String body;
  final List<String> tags;
  final bool reverse;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final textBlock = Column(
      crossAxisAlignment: wide && !reverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!wide) ...[
          Text(
            number,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.orange),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          title,
          textAlign: wide && !reverse ? TextAlign.right : TextAlign.left,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: -0.4),
        ),
        const SizedBox(height: 12),
        Text(
          body,
          textAlign: wide && !reverse ? TextAlign.right : TextAlign.left,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.gray600, height: 1.6),
        ),
      ],
    );

    final deliverables = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: wide && reverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVERABLES',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.gray400),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: wide && reverse ? WrapAlignment.end : WrapAlignment.start,
            children: tags
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(t, style: TextStyle(fontSize: 12, color: AppColors.gray600)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );

    if (!wide) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [textBlock, const SizedBox(height: 24), deliverables],
        ),
      );
    }

    final left = reverse ? deliverables : textBlock;
    final right = reverse ? textBlock : deliverables;

    return Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: reverse ? 0 : 48),
              child: left,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.bg, width: 8),
            ),
            child: Text(
              number,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: reverse ? 48 : 0),
              child: right,
            ),
          ),
        ],
      ),
    );
  }
}
