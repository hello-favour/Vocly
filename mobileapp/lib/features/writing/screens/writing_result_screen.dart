import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/writing/models/feedback_result.dart';
import 'package:mobileapp/features/writing/widgets/issue_row.dart';

class WritingResultScreen extends StatelessWidget {
  const WritingResultScreen({super.key, required this.result});

  final FeedbackResult result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your feedback')),
      body: AppScreen(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  AppTexts.title2(
                    '${result.overallScore}',
                    context,
                    center: true,
                  ),
                  AppTexts.caption1(
                    'Clarity score',
                    context,
                    color: AppColors.textTertiary,
                    center: true,
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 44,
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacings.elementSpacingLarge,
                ),
                color: AppColors.whiteWith(0.1),
              ),
              AppPill(label: '${result.tone} tone'),
            ],
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacings.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: AppSpacings.cardBorderRadius,
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.caption1(
                  'Suggested version',
                  context,
                  color: AppColors.success,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: AppSpacings.elementSpacingSmall),
                AppTexts.body(
                  '"${result.corrected}"',
                  context,
                  color: AppColors.success,
                ),
              ],
            ),
          ),
          SectionLabel('Issues found (${result.issues.length})'),
          for (final issue in result.issues)
            IssueRow(
              badge: issue.type,
              text:
                  '"${issue.original}" → "${issue.suggestion}" — ${issue.explanation}',
            ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppCard(
            color: AppColors.primaryWith(0.12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.caption1(
                  'Confidence tip',
                  context,
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: AppSpacings.elementSpacingSmall),
                AppTexts.body(
                  result.confidenceTip,
                  context,
                  color: AppColors.primaryLight,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppButton(
            label: 'Check another',
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
