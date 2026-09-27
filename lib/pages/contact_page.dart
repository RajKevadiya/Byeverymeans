import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_buttons.dart';
import '../widgets/content_padding.dart';
import '../widgets/outcome_grid.dart';
import '../widgets/reveal.dart';
import '../widgets/section_label.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  String? _budget;
  String? _source;

  static const _promises = [
    (
      Icons.chat_bubble_outline,
      'No Obligations',
      'A simple introductory conversation to see if we\'re a fit. No hard pitch, just thoughts — no strings attached.',
    ),
    (
      Icons.schedule,
      'No Assumptions',
      'We listen more than we talk. Every project begins with a clean slate to truly understand your distinct goals.',
    ),
    (
      Icons.thumb_up_outlined,
      'No Pressure',
      'Great partnerships are built on mutual trust. We\'ll give you the space and time to decide what is right for you.',
    ),
  ];

  static const _nextSteps = [
    OutcomeItem(number: '01', title: 'Review', description: 'We review your submission thoroughly.'),
    OutcomeItem(number: '02', title: 'Discovery Call', description: 'A 30-min call to explore potential.'),
    OutcomeItem(number: '03', title: 'Collab Scope', description: 'Mapping out needs and goals.'),
    OutcomeItem(number: '04', title: 'Proposal', description: 'A detailed project plan and cost.'),
    OutcomeItem(number: '05', title: 'Begin Project', description: 'Contracts signed, timeline starts.'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = Breakpoints.isMd(context);
    final lg = Breakpoints.isLg(context);

    return ContentPadding(
      vertical: wide ? 96 : 72,
      child: Column(
        children: [
          Reveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: wide ? 56 : 36,
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                    letterSpacing: -1.5,
                  ),
                  children: const [
                    TextSpan(text: "Let's build something "),
                    TextSpan(
                      text: 'recognised',
                      style: TextStyle(color: AppColors.orange),
                    ),
                    TextSpan(text: ', remembered and chosen'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 96),
          const Divider(color: AppColors.border),
          const SizedBox(height: 64),
          const Reveal(child: SectionLabel('Offering And Promise', fontSize: 18)),
          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final count = wide ? 3 : 1;
              final gap = 24.0;
              final itemWidth = (constraints.maxWidth - gap * (count - 1)) / count;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < _promises.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: Reveal(
                        delay: Duration(milliseconds: i * 90),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.orange.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(_promises[i].$1, color: AppColors.orange, size: 20),
                              ),
                              const SizedBox(height: 24),
                              Text(_promises[i].$2, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),
                              const SizedBox(height: 12),
                              Text(
                                _promises[i].$3,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.gray500,
                                  height: 1.5,
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
          const SizedBox(height: 64),
          const Divider(color: AppColors.border),
          const SizedBox(height: 64),
          Builder(
            builder: (context) {
              final info = Reveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel('Your Business & Project', fontSize: 18),
                    const SizedBox(height: 8),

                    Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, letterSpacing: -0.6, height: 1.2),
                        children: const [
                          TextSpan(text: 'We\'d love to hear about\t'),
                          TextSpan(
                            text: 'Your Ambitions',
                            style: TextStyle(color: AppColors.orange),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    Text(
                      'EMAIL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                        color: AppColors.gray400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('hello@byallmeans.com', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              );

              final form = Reveal(
                delay: const Duration(milliseconds: 120),
                child: Container(
                  padding: EdgeInsets.all(wide ? 48 : 28),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (wide)
                          Row(
                            children: [
                              Expanded(child: _field('Name', 'Your full name')),
                              const SizedBox(width: 24),
                              Expanded(child: _field('Email', 'Your email address')),
                            ],
                          )
                        else ...[
                          _field('Name', 'Your full name'),
                          const SizedBox(height: 24),
                          _field('Email', 'Your email address'),
                        ],
                        const SizedBox(height: 24),
                        _field('Company', 'Your company name'),
                        const SizedBox(height: 24),
                        _field(
                          'What are you looking for help with?',
                          'Tell us about your project — brand identity, website design, campaigns, etc.',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),
                        _field(
                          'What challenges are you facing?',
                          'What is the primary problem you are trying to solve?',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 24),
                        if (wide) Row(children: [Expanded(child: _sourceDropdown())]) else ...[_sourceDropdown()],
                        const SizedBox(height: 32),
                        OrangeButton(
                          label: 'Submit Enquiry →',
                          expanded: true,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Form submitted!', style: TextStyle()),
                                backgroundColor: AppColors.dark,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (lg) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: info),
                    const SizedBox(width: 64),
                    Expanded(flex: 8, child: form),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [info, const SizedBox(height: 48), form],
              );
            },
          ),
          const SizedBox(height: 128),
          const Divider(color: AppColors.border),
          const SizedBox(height: 64),
          const Reveal(child: SectionLabel('What Happens Next')),
          const SizedBox(height: 24),
          Reveal(
            child: Text('The path forward', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, letterSpacing: -0.4)),
          ),
          const SizedBox(height: 48),
          const OutcomeGrid(items: _nextSteps),
          const SizedBox(height: 32),
          Reveal(
            child: Text(
              'Typically 2-3 weeks from enquiry to kick-off.',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: AppColors.gray400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.gray500),
        ),
        const SizedBox(height: 12),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hint),
        ),
      ],
    );
  }

  Widget _budgetDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BUDGET',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.gray500),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _budget,
          hint: Text('Select a budget...', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
          items: const [
            DropdownMenuItem(value: '10-25', child: Text('\$10k - \$25k')),
            DropdownMenuItem(value: '25-50', child: Text('\$25k - \$50k')),
            DropdownMenuItem(value: '50+', child: Text('\$50k+')),
          ],
          onChanged: (v) => setState(() => _budget = v),
        ),
      ],
    );
  }

  Widget _sourceDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HOW DID YOU HEAR ABOUT US?',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, letterSpacing: 2, color: AppColors.gray500),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _source,
          hint: Text('Select an option...', style: TextStyle(fontSize: 14, color: AppColors.gray500)),
          items: const [
            DropdownMenuItem(value: 'google', child: Text('Google Search')),
            DropdownMenuItem(value: 'referral', child: Text('Referral')),
            DropdownMenuItem(value: 'social', child: Text('Social Media')),
            DropdownMenuItem(value: 'other', child: Text('Other')),
          ],
          onChanged: (v) => setState(() => _source = v),
        ),
      ],
    );
  }
}
