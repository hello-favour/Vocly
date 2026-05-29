import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';

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
      appBar: AppBar(title: const Text('Pronunciation score')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              children: [
                Text(word, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                Text(
                  '$score',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: color),
                ),
                Text(message),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Focus sounds',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  'Speechace phoneme details will appear here when the API key is connected.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Try again',
            icon: Icons.refresh,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
