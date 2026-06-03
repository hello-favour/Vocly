import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class PhonemeRow extends StatelessWidget {
  const PhonemeRow({
    super.key,
    required this.label,
    required this.score,
    required this.color,
  });

  final String label;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacings.compactControlPaddingVertical,
      ),
      child: Row(
        children: [
          SizedBox(width: 72, child: AppTexts.caption1(label, context)),
          Expanded(
            child: LinearProgressIndicator(
              value: score / 100,
              color: color,
              backgroundColor: AppColors.border,
              minHeight: AppSpacings.elementSpacingTiny,
            ),
          ),
          const SizedBox(width: AppSpacings.iconGap),
          AppTexts.caption1('$score', context, color: color),
        ],
      ),
    );
  }
}
