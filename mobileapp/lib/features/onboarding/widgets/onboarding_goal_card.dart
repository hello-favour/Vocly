import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';

class OnboardingGoalCard extends StatelessWidget {
  const OnboardingGoalCard({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacings.cardBorderRadius,
      child: AppCard(
        selected: selected,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.controlPaddingHorizontal,
          vertical: AppSpacings.sectionSpacing,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primaryWith(0.12)
                    : AppColors.backgroundDeep,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: selected ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            AppTexts.headline(
              label,
              context,
              center: true,
              color: selected ? AppColors.primary : AppColors.ink,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
