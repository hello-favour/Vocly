import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class WritingHistoryItem extends StatelessWidget {
  const WritingHistoryItem({
    super.key,
    required this.score,
    required this.text,
    required this.meta,
    required this.tone,
  });

  final int score;
  final String text;
  final String meta;
  final String tone;

  @override
  Widget build(BuildContext context) {
    final color = score >= 75
        ? AppColors.success
        : score >= 50
        ? AppColors.warning
        : AppColors.danger;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacings.elementSpacing),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: AppSpacings.defaultBorderRadiusTextField,
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Center(
              child: AppTexts.headline(
                '$score',
                context,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacings.elementSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.caption1(
                  text,
                  context,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacings.elementSpacingTiny),
                AppTexts.caption2(meta, context, color: AppColors.textTertiary),
              ],
            ),
          ),
          AppPill(label: tone, tone: AppPillTone.green),
        ],
      ),
    );
  }
}
