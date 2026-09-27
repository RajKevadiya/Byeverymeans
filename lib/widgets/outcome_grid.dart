import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'reveal.dart';

class OutcomeItem {
  const OutcomeItem({required this.number, required this.title, required this.description});

  final String number;
  final String title;
  final String description;
}

class OutcomeGrid extends StatelessWidget {
  const OutcomeGrid({super.key, required this.items});

  final List<OutcomeItem> items;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= 768 ? 5 : 2;
    const spacing = 16.0;

    final rows = <List<OutcomeItem>>[];
    for (var i = 0; i < items.length; i += crossAxisCount) {
      rows.add(items.sublist(i, (i + crossAxisCount).clamp(0, items.length)));
    }

    return Column(
      children: [
        for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) ...[
          if (rowIndex > 0) const SizedBox(height: spacing),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < rows[rowIndex].length; i++) ...[
                  if (i > 0) const SizedBox(width: spacing),
                  Expanded(
                    child: Reveal(
                      delay: Duration(milliseconds: (rowIndex * crossAxisCount + i) * 80),
                      child: _OutcomeCard(item: rows[rowIndex][i]),
                    ),
                  ),
                ],
                // Keep last-row cards the same width when the row is incomplete.
                for (var i = rows[rowIndex].length; i < crossAxisCount; i++) ...[
                  const SizedBox(width: spacing),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _OutcomeCard extends StatelessWidget {
  const _OutcomeCard({required this.item});

  final OutcomeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            item.number,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.orange),
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
