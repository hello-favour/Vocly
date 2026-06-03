import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';

class OnboardingChoiceTile extends StatelessWidget {
  const OnboardingChoiceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacings.controlPaddingVertical,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacings.cardBorderRadius,
        child: AppCard(
          selected: selected,
          padding: const EdgeInsets.all(AppSpacings.cardPadding),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primaryWith(0.12)
                      : AppColors.backgroundDeep,
                  borderRadius: AppSpacings.defaultBorderRadius,
                ),
                child: Icon(
                  icon,
                  size: 26,
                  color: selected ? AppColors.primary : AppColors.textTertiary,
                ),
              ),
              const SizedBox(width: AppSpacings.controlPaddingVertical),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.headline(
                      title,
                      context,
                      color: selected ? AppColors.primary : AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: AppSpacings.elementSpacingTiny),
                    AppTexts.caption2(
                      subtitle,
                      context,
                      color: selected
                          ? AppColors.primaryLight.withValues(alpha: 0.82)
                          : AppColors.textTertiary,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
