import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class CoinRow extends StatelessWidget {
  const CoinRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.elementSpacingSmall,
      ),
      child: Row(
        children: [
          AppTexts.caption1(label, context, color: AppColors.textSecondary),
          const Spacer(),
          AppTexts.caption1(
            value,
            context,
            color: AppColors.warning,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
