import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/pronunciation/widgets/phoneme_row.dart';

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
        ? 'Keep practising!'
        : score < 75
        ? 'Getting there!'
        : 'Excellent!';

    return Scaffold(
      appBar: AppBar(title: const Text('Your result')),
      body: AppScreen(
        children: [
          AppTexts.largeTitle(
            '$score',
            context,
            color: color,
            center: true,
            fontSize: 48,
          ),
          AppTexts.caption1(
            'out of 100',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.caption1(
                  'Phoneme breakdown',
                  context,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(height: AppSpacings.elementSpacingLarge),
                const PhonemeRow(
                  label: '/ɑːr/',
                  score: 90,
                  color: AppColors.success,
                ),
                const PhonemeRow(
                  label: '/tɪk/',
                  score: 75,
                  color: AppColors.warning,
                ),
                const PhonemeRow(
                  label: '/jʊ.lɪt/',
                  score: 80,
                  color: AppColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppButton(
            label: 'Try again',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppButton(
            label: 'Try another word',
            variant: AppButtonVariant.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
