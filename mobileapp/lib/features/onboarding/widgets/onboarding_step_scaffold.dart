import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/step_progress.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class OnboardingStepScaffold extends StatelessWidget {
  const OnboardingStepScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.onNext,
    this.buttonLabel = 'Continue',
  });

  final int step;
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback onNext;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.screenPadding,
        vertical: 26,
      ),
      children: [
        StepProgress(current: step, total: 5),
        const SizedBox(height: 18),
        AppTexts.caption2(
          'Step $step of 5',
          context,
          color: AppColors.primaryLight,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        AppTexts.title1(title, context),
        const SizedBox(height: 8),
        AppTexts.body(
          subtitle,
          context,
          color: AppColors.textSecondary,
          fontSize: 17,
        ),
        const SizedBox(height: 24),
        child,
        const SizedBox(height: 28),
        AppButton(label: buttonLabel, onPressed: onNext),
      ],
    );
  }
}
