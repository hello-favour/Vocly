import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/texts/app_texts.dart';

class WritingHistoryTabs extends StatelessWidget {
  const WritingHistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.whiteWith(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          _Tab(label: 'This week', active: true),
          _Tab(label: 'This month'),
          _Tab(label: 'All'),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withValues(alpha: 0.65) : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: AppTexts.caption2(
          label,
          context,
          center: true,
          color: active ? Colors.white : AppColors.textTertiary,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
