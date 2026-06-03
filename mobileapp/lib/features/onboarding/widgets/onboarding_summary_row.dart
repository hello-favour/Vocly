import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class OnboardingSummaryRow extends StatelessWidget {
  const OnboardingSummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.compactControlPaddingVertical,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTexts.body(label, context, color: AppColors.textTertiary),
          AppTexts.body(
            value,
            context,
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
