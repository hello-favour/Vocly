import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';

class FeedbackOption extends StatelessWidget {
  const FeedbackOption({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

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
          horizontal: AppSpacings.elementSpacing,
          vertical: AppSpacings.compactControlPaddingVertical,
        ),
        child: Row(
          children: [
            if (selected) ...[
              const Icon(Icons.check, color: AppColors.primaryLight, size: 16),
              const SizedBox(width: AppSpacings.elementSpacingSmall),
            ],
            Expanded(
              child: AppTexts.caption1(
                label,
                context,
                color: selected
                    ? AppColors.primaryLight
                    : AppColors.textTertiary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
