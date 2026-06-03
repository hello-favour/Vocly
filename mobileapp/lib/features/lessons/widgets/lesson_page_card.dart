import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';

class LessonPageCard extends StatelessWidget {
  const LessonPageCard({
    super.key,
    required this.pill,
    required this.title,
    required this.body,
    required this.accent,
  });

  final Widget pill;
  final String title;
  final String body;
  final String accent;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primaryWith(0.18),
      padding: const EdgeInsets.all(AppSpacings.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pill,
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTexts.title2(title, context),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.caption1(body, context, color: AppColors.textSecondary),
          const Divider(height: AppSpacings.elementSpacingLarge),
          AppTexts.caption1(
            accent,
            context,
            color: AppColors.primaryLight,
            fontStyle: FontStyle.italic,
          ),
          const Spacer(),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLightWith(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryLightWith(0.35)),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: AppColors.primaryLight,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
