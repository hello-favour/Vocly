import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class IssueRow extends StatelessWidget {
  const IssueRow({super.key, required this.badge, required this.text});

  final String badge;
  final String text;

  @override
  Widget build(BuildContext context) {
    final tone = badge == 'grammar'
        ? AppPillTone.red
        : badge == 'clarity'
        ? AppPillTone.amber
        : AppPillTone.violet;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.whiteWith(0.06))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPill(label: badge, tone: tone),
          const SizedBox(width: 8),
          Expanded(
            child: AppTexts.caption1(
              text,
              context,
              color: AppColors.textSecondary,
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}
