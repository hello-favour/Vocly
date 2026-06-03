import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class TabProgress extends StatelessWidget {
  const TabProgress({super.key, required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacings.elementSpacingSmall,
        ),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withValues(alpha: 0.65) : null,
          borderRadius: AppSpacings.defaultBorderRadiusTextField,
        ),
        child: AppTexts.caption1(
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
