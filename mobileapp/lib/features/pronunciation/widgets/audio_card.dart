import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';

class AudioCard extends StatelessWidget {
  const AudioCard({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacings.elementSpacing),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: active ? AppColors.primaryLight : AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.caption1(
            label,
            context,
            color: active ? AppColors.textSecondary : AppColors.textTertiary,
            center: true,
          ),
        ],
      ),
    );
  }
}
