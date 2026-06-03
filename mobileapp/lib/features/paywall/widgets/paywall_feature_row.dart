import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class PaywallFeatureRow extends StatelessWidget {
  const PaywallFeatureRow(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.elementSpacingTiny),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: AppColors.success, size: 12),
          ),
          const SizedBox(width: AppSpacings.elementSpacingSmall),
          Expanded(
            child: AppTexts.caption1(
              label,
              context,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
