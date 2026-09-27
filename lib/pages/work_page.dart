import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/content_padding.dart';
import '../widgets/cta_banner.dart';
import '../widgets/outcome_grid.dart';
import '../widgets/reveal.dart';
import '../widgets/section_label.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key, required this.onNavigate});

  final ValueChanged<AppPage> onNavigate;

  static const _projects = [
    (
      'M',
      'Meridian',
      'Brand Identity + Digital Platform',
      'Meridian needed to consolidate its global presence into one clear, unifying brand that spoke to both enterprise clients and the modern consumer, while standardizing their extensive digital ecosystem.',
      'An exhaustive system, distilling complex elements down into a simple and elegant UI. We built a framework that scales infinitely, prioritizing accessibility and clarity.',
      ['Brand Strategy', 'Visual Identity'],
      false,
    ),
    (
      'N',
      'Nexus',
      'Digital Product + UX/UI',
      'Nexus had a powerful tool but suffered from a confusing user experience. They needed to modernize their product without alienating their highly technical, loyal user base.',
      'We re-architected the entire experience from the ground up — simplifying complex workflows, introducing a refreshed design language, and optimizing user journeys.',
      ['UX Strategy', 'UI Design'],
      true,
    ),
    (
      'F',
      'Forma',
      'Packaging & E-commerce',
      'Forma required a packaging overhaul that felt premium yet sustainable. The unboxing experience needed to translate perfectly into their new e-commerce storefront.',
      'A tactile, minimalist packaging strategy paired with a sleek, motion-driven digital store. The result bridges the physical and digital seamlessly.',
      ['Packaging Design', 'E-commerce'],
      false,
    ),
  ];

  static const _outcomes = [
    OutcomeItem(number: '01', title: 'Recognition', description: 'Stand out in a crowded market'),
    OutcomeItem(number: '02', title: 'Consistency', description: 'Unified touchpoints everywhere'),
    OutcomeItem(number: '03', title: 'Trust', description: 'Credibility built into design'),
    OutcomeItem(number: '04', title: 'Clarity', description: 'Visuals communicating purpose'),
    OutcomeItem(number: '05', title: 'Growth', description: 'Design driving tangible results'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

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
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: TextStyle(
                          fontSize: wide ? 56 : 36,
                          fontWeight: FontWeight.w500,
                          height: 1.05,
                          letterSpacing: -1,
                        ),
                        children: const [
                          TextSpan(text: 'Every project begins with a '),
                          TextSpan(
                            text: 'challenge',
                            style: TextStyle(color: AppColors.orange),
                          ),
                          TextSpan(text: '. Every outcome\nbegins with clarity.'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 96),
              const Divider(color: AppColors.border),
              const SizedBox(height: 64),
              const Reveal(child: SectionLabel('Our Work', fontSize: 18)),
              const SizedBox(height: 25),

              ..._projects.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 96),
                  child: Reveal(
                    child: _ProjectStory(
                      letter: p.$1,
                      name: p.$2,
                      category: p.$3,
                      challenge: p.$4,
                      approach: p.$5,
                      tags: p.$6,
                      reverse: p.$7,
                    ),
                  ),
                ),
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: 24),
              Reveal(
                child: Center(
                  child: Text(
                    'Measurable Outcomes',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, letterSpacing: -0.4),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const OutcomeGrid(items: _outcomes),
            ],
          ),
        ),
        CtaBanner(
          title: 'Ready to write your story?',
          subtitle: "We're always looking for new organisations to help. Tell us what you're working on.",
          onPressed: () => onNavigate(AppPage.contact),
        ),
      ],
    );
  }
}

class _ProjectStory extends StatelessWidget {
  const _ProjectStory({
    required this.letter,
    required this.name,
    required this.category,
    required this.challenge,
    required this.approach,
    required this.tags,
    required this.reverse,
  });

  final String letter;
  final String name;
  final String category;
  final String challenge;
  final String approach;
  final List<String> tags;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.toUpperCase(),
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.orange),
        ),
        const SizedBox(height: 16),
        Text(name, style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500, letterSpacing: -1)),
        const SizedBox(height: 40),
        Text(
          'THE CHALLENGE',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.dark),
        ),
        const SizedBox(height: 8),
        Text(
          challenge,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.gray600, height: 1.6),
        ),
        const SizedBox(height: 32),
        Text(
          'OUR APPROACH',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.dark),
        ),
        const SizedBox(height: 8),
        Text(
          approach,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.gray600, height: 1.6),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags
              .map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(t, style: TextStyle(fontSize: 11, color: AppColors.gray600)),
                ),
              )
              .toList(),
        ),
      ],
    );

    final visual = AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: TextStyle(
            fontSize: wide ? 160 : 120,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            letterSpacing: -4,
            color: AppColors.border,
          ),
        ),
      ),
    );

    if (!wide) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [text, const SizedBox(height: 40), visual]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: reverse
          ? [Expanded(flex: 7, child: visual), const SizedBox(width: 64), Expanded(flex: 5, child: text)]
          : [Expanded(flex: 5, child: text), const SizedBox(width: 64), Expanded(flex: 7, child: visual)],
    );
  }
}
