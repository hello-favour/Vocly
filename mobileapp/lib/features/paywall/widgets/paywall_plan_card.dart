import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class PaywallPlanCard extends StatelessWidget {
  const PaywallPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.badge,
    this.selected = false,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String price;
  final String? badge;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacings.defaultBorderRadiusTextField,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.elementSpacing,
          vertical: AppSpacings.elementSpacing,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryWith(0.12) : AppColors.card,
          borderRadius: AppSpacings.defaultBorderRadiusTextField,
          border: Border.all(
            color: selected ? AppColors.primaryWith(0.55) : AppColors.border,
            width: selected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(width: AppSpacings.elementSpacingSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.caption1(
                    title,
                    context,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  AppTexts.caption2(
                    subtitle,
                    context,
                    color: selected
                        ? AppColors.primaryLight.withValues(alpha: 0.7)
                        : AppColors.textTertiary,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacings.elementSpacingSmall,
                      vertical: AppSpacings.elementSpacingTiny,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWith(0.15),
                      borderRadius: AppSpacings.defaultBorderRadiusTextField,
                    ),
                    child: AppTexts.caption2(
                      badge!,
                      context,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingTiny),
                ],
                AppTexts.caption1(
                  price,
                  context,
                  color: selected
                      ? AppColors.primaryLight
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
