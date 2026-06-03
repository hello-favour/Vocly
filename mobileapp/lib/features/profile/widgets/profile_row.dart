import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.elementSpacingSmall,
      ),
      child: Row(
        children: [
          AppTexts.caption1(label, context, color: AppColors.textTertiary),
          const Spacer(),
          if (icon != null) ...[
            Icon(icon, size: 14, color: AppColors.primaryLight),
            const SizedBox(width: AppSpacings.elementSpacingTiny),
          ],
          AppTexts.caption1(
            value,
            context,
            color: AppColors.primaryLight,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
