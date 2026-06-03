import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/text_theme.dart';

enum AppPillTone { violet, green, amber, red }

class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    this.icon,
    this.tone = AppPillTone.violet,
  });

  final String label;
  final IconData? icon;
  final AppPillTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      AppPillTone.violet => AppColors.primaryLight,
      AppPillTone.green => AppColors.success,
      AppPillTone.amber => AppColors.warning,
      AppPillTone.red => AppColors.danger,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.elementSpacing,
        vertical: AppSpacings.elementSpacingTiny,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: AppSpacings.chipBorderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: color, size: 16),
            const SizedBox(width: AppSpacings.elementSpacingTiny),
          ],
          Text(label, style: AppTextThemes.chipLabel.copyWith(color: color)),
        ],
      ),
    );
  }
}
