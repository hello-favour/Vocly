import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class PronunciationResultScreen extends StatelessWidget {
  const PronunciationResultScreen({
    super.key,
    required this.word,
    required this.score,
  });

  final String word;
  final int score;

  @override
  Widget build(BuildContext context) {
    final color = score < 50
        ? AppColors.danger
        : score < 75
        ? AppColors.warning
        : AppColors.success;
    final message = score < 50
        ? 'Try it once more'
        : score < 75
        ? 'You’re getting closer'
        : 'That sounded confident';

    return Scaffold(
      appBar: AppBar(title: const Text('Speaking result')),
      body: AppScreen(
        children: [
          AppTexts.largeTitle(
            '$score',
            context,
            color: color,
            center: true,
            fontSize: 56,
          ),
          AppTexts.caption1(
            'pronunciation score',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          Center(
            child: AppPill(
              label: message,
              tone: score >= 75 ? AppPillTone.green : AppPillTone.amber,
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppCard(
            color: AppColors.primaryWith(0.06),
            child: Column(
              children: [
                AppTexts.caption1(
                  'PHRASE PRACTISED',
                  context,
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w700,
                  center: true,
                ),
                const SizedBox(height: AppSpacings.elementSpacing),
                AppTexts.title2(
                  '“$word”',
                  context,
                  color: AppColors.primary,
                  center: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.body(
            score >= 75
                ? 'Good work. Repeat it once more to make the phrase feel natural.'
                : 'Slow down, keep the words connected, and try the phrase again.',
            context,
            color: AppColors.textSecondary,
            center: true,
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppButton(
            label: 'Try again',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
