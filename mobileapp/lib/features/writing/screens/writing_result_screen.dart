import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../models/feedback_result.dart';

class WritingResultScreen extends StatelessWidget {
  const WritingResultScreen({super.key, required this.result});

  final FeedbackResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Writing feedback')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(color: const Color(0xFFF0F2F0), child: Text(result.original)),
          const SizedBox(height: 12),
          AppCard(
            color: const Color(0xFFEAF7EF),
            child: Text(
              result.corrected,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.success),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Metric(label: 'Score', value: '${result.overallScore}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Metric(label: 'Tone', value: result.tone),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final issue in result.issues)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(label: Text(issue.type)),
                    Text(
                      issue.original,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      issue.suggestion,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(issue.explanation),
                  ],
                ),
              ),
            ),
          AppCard(
            child: Text('${result.summary}\n\nTip: ${result.confidenceTip}'),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Check another',
            icon: Icons.refresh,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          Text(label),
        ],
      ),
    );
  }
}
