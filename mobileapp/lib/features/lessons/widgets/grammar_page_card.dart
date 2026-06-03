import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class GrammarPageCard extends StatelessWidget {
  const GrammarPageCard({super.key, required this.rule, required this.example});

  final String rule;
  final String example;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primaryWith(0.18),
      padding: const EdgeInsets.all(AppSpacings.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppPill(label: 'Grammar tip', tone: AppPillTone.green),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTexts.headline(rule, context),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.caption1(example, context, color: AppColors.textSecondary),
          const Divider(height: AppSpacings.elementSpacingLarge),
          const ExampleBox(
            label: 'Incorrect',
            text: 'I work here since 3 years.',
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          const ExampleBox(
            label: 'Correct',
            text: 'I have worked here for 3 years.',
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}

class ExampleBox extends StatelessWidget {
  const ExampleBox({
    super.key,
    required this.label,
    required this.text,
    required this.color,
  });

  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.elementSpacing,
        vertical: AppSpacings.elementSpacingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppSpacings.defaultBorderRadiusTextField,
        border: Border.all(color: color.withValues(alpha: 0.2), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.caption2(label, context, color: color),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.caption1(text, context, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
