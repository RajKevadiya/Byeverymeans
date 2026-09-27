import 'package:flutter/material.dart';

import '../shell/app_page.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'content_padding.dart';
import 'section_label.dart';

class SiteFooter extends StatelessWidget {
  const SiteFooter({super.key, required this.current, required this.onNavigate});

  final AppPage current;
  final ValueChanged<AppPage> onNavigate;

  static const _values = [
    'Ambition Over Size',
    'Clarity Before Complexity',
    'Purposeful Craft',
    'Commitment Without Compromise',
    'Curious by Nature',
  ];

  static const _personality = ['Confident', 'Curious', 'Thoughtful', 'Direct', 'Committed', 'Grounded'];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);

    return Container(
      width: double.infinity,
      color: AppColors.dark,
      padding: EdgeInsets.fromLTRB(0, wide ? 96 : 72, 0, 48),
      child: ContentPadding(
        child: Column(
          children: [
            _purposeSection(wide),
            const SizedBox(height: 48),
            Text(
              'hello@byallmeans.com',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: AppColors.bg,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.gray600,
              ),
            ),
            const SizedBox(height: 96),
            Divider(color: AppColors.gray800, height: 1),
            const SizedBox(height: 64),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _brand()),
                  Expanded(child: _menu()),
                  Expanded(child: _contact()),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_brand(), const SizedBox(height: 48), _menu(), const SizedBox(height: 48), _contact()],
              ),
            const SizedBox(height: 64),
            Divider(color: AppColors.gray800, height: 1),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '© 2026 BY EVERY MEANS. All rights reserved.',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300, color: AppColors.gray500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _purposeSection(bool wide) {
    return switch (current) {
      AppPage.services => _cardSection(label: 'Our Values', items: _values, wide: wide),
      AppPage.process => _cardSection(label: 'Our Personality', items: _personality, wide: wide),
      AppPage.work => _workSection(label: 'Our Personality', items: _personality, wide: wide),
      _ => _homePurpose(wide),
    };
  }

  Widget _homePurpose(bool wide) {
    return Column(
      children: [
        const SectionLabel('Our Purpose', color: AppColors.gray400, fontSize: 18),
        const SizedBox(height: 32),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: wide ? 48 : 36,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.8,
                color: AppColors.bg,
                height: 1.2,
              ),
              children: const [
                TextSpan(text: 'Building Brands that '),
                TextSpan(
                  text: 'Recognized,\n',
                  style: TextStyle(color: AppColors.orange),
                ),
                TextSpan(
                  text: 'Remembered and Chosen',
                  style: TextStyle(color: AppColors.orange),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _cardSection({required String label, required List<String> items, required bool wide}) {
    return Column(
      children: [
        SectionLabel(label, color: AppColors.gray400, fontSize: 18),
        const SizedBox(height: 32),
        LayoutBuilder(
          builder: (context, constraints) {
            final count = wide ? 3 : 1;
            final gap = 16.0;
            final itemWidth = (constraints.maxWidth - gap * (count - 1)) / count;

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: items.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.gray800),
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bg,
                        letterSpacing: -0.2,
                        height: 1.3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _workSection({String? label, required List<String> items, required bool wide}) {
    return Container(
      width: double.infinity,
      color: AppColors.dark,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _QuoteLine('Every project begins with ', 'listening'),
          const SizedBox(height: 20),
          _QuoteLine('Every decision has a ', 'purpose'),
          const SizedBox(height: 20),
          _QuoteLine('Every system is built to ', 'last'),
        ],
      ),
    );
  }

  Widget _brand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/logo_orange.jpg", height: 120, width: 120, fit: BoxFit.contain),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'A design agency crafting meaningful brands and digital experiences for ambitious businesses.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.gray400, height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _menu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Menu', color: AppColors.gray500),
        const SizedBox(height: 24),
        ...[...AppPage.navItems, AppPage.contact].map((page) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () => onNavigate(page),
              child: Text(
                page == AppPage.contact ? 'Contact Us' : page.label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color(0xFFD1D5DB)),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Contact', color: AppColors.gray500),
        const SizedBox(height: 24),
        Text(
          'hello@byallmeans.com',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color(0xFFD1D5DB)),
        ),
        const SizedBox(height: 16),
        Text(
          'Surat, Gujarat, India',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color(0xFFD1D5DB)),
        ),
      ],
    );
  }
}

class _QuoteLine extends StatelessWidget {
  const _QuoteLine(this.prefix, this.accent);

  final String prefix;
  final String accent;

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: wide ? 36 : 28,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: '"$prefix'),
          TextSpan(
            text: accent,
            style: const TextStyle(color: AppColors.orange, fontWeight: FontWeight.w500),
          ),
          const TextSpan(text: '."'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
