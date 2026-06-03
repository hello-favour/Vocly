import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import 'texts/app_texts.dart';

class AppStatCard extends StatelessWidget {
  const AppStatCard({
    super.key,
    required this.value,
    required this.label,
    this.color = AppColors.textPrimary,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.elementSpacingLarge,
        vertical: AppSpacings.elementSpacing,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteWith(0.06),
        borderRadius: AppSpacings.defaultBorderRadiusTextField,
        border: Border.all(
          color: AppColors.whiteWith(0.07),
          width: AppSpacings.cardOutlineWidth,
        ),
      ),
      child: Column(
        children: [
          AppTexts.title2(
            value,
            context,
            color: color,
            fontWeight: FontWeight.w600,
            center: true,
          ),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.caption1(
            label,
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
        ],
      ),
    );
  }
}
