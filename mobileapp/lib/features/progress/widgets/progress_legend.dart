import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class ProgressLegend extends StatelessWidget {
  const ProgressLegend({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSpacings.elementSpacing,
          height: AppSpacings.elementSpacing,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppSpacings.defaultBorderRadiusTextField,
          ),
        ),
        const SizedBox(width: AppSpacings.elementSpacingSmall),
        AppTexts.caption1(label, context, color: AppColors.textTertiary),
      ],
    );
  }
}
