import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

import '../widgets/onboarding_choice_tile.dart';
import '../widgets/onboarding_goal_card.dart';
import '../widgets/onboarding_step_scaffold.dart';
import '../widgets/onboarding_summary_row.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final pageController = PageController();
  int page = 0;
  String level = 'intermediate';
  String goal = 'professional';
  int minutes = 5;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
    final name = session.displayName.trim().isEmpty
        ? 'Vocly learner'
        : session.displayName.trim();

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) => setState(() => page = value),
          children: [
            OnboardingStepScaffold(
              step: 1,
              title: 'Where do you want to sound better?',
              subtitle: 'Your answer chooses the phrases Vocly shows first.',
              onNext: _next,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.98,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  OnboardingGoalCard(
                    icon: Icons.work_outline,
                    label: 'At work',
                    selected: goal == 'professional',
                    onTap: () => setState(() => goal = 'professional'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.forum_outlined,
                    label: 'Socially',
                    selected: goal == 'social',
                    onTap: () => setState(() => goal = 'social'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.badge_outlined,
                    label: 'Interviews',
                    selected: goal == 'interview',
                    onTap: () => setState(() => goal = 'interview'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.auto_awesome_outlined,
                    label: 'Everywhere',
                    selected: goal == 'all',
                    onTap: () => setState(() => goal = 'all'),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 2,
              title: 'Which sounds most like you?',
              subtitle: 'Vocly is for people who already speak English.',
              onNext: _next,
              child: Column(
                children: [
                  OnboardingChoiceTile(
                    icon: Icons.chat_bubble_outline,
                    title: 'I can communicate',
                    subtitle: 'I want simpler, more natural phrases',
                    selected: level == 'beginner',
                    onTap: () => setState(() => level = 'beginner'),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.record_voice_over_outlined,
                    title: 'I speak English daily',
                    subtitle: 'I want to sound confident and polished',
                    selected: level == 'intermediate',
                    onTap: () => setState(() => level = 'intermediate'),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.business_center_outlined,
                    title: 'I use English professionally',
                    subtitle: 'I want sharper, more advanced expression',
                    selected: level == 'advanced',
                    onTap: () => setState(() => level = 'advanced'),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 3,
              title: 'Choose your daily habit',
              subtitle: 'Short practice is easier to repeat every day.',
              onNext: _next,
              child: Column(
                children: [
                  OnboardingChoiceTile(
                    icon: Icons.bolt_outlined,
                    title: '5 minutes',
                    subtitle: 'One upgrade and speaking practice',
                    selected: minutes == 5,
                    onTap: () => setState(() => minutes = 5),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.local_fire_department_outlined,
                    title: '10 minutes',
                    subtitle: 'Three upgrades for faster improvement',
                    selected: minutes == 10,
                    onTap: () => setState(() => minutes = 10),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.workspace_premium_outlined,
                    title: '15 minutes',
                    subtitle: 'A deeper daily speaking session',
                    selected: minutes == 15,
                    onTap: () => setState(() => minutes = 15),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 4,
              title: 'Your first upgrade is ready',
              subtitle: 'This is how every short Vocly lesson works.',
              buttonLabel: 'Start my first upgrade',
              onNext: () async {
                await ref
                    .read(appSessionProvider.notifier)
                    .completeOnboarding(
                      displayName: name,
                      skillLevel: level,
                      goal: goal,
                      dailyGoalMinutes: minutes,
                    );
                if (context.mounted) context.go(AppRoutes.lessonsTab);
              },
              child: Column(
                children: [
                  AppCard(
                    color: AppColors.primaryWith(0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts.caption1(
                          'BASIC → PROFESSIONAL',
                          context,
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: AppSpacings.elementSpacingLarge),
                        AppTexts.caption2(
                          'BASIC',
                          context,
                          color: AppColors.textTertiary,
                        ),
                        AppTexts.title2(
                          'I’m very busy.',
                          context,
                          color: AppColors.textTertiary,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacings.elementSpacing,
                          ),
                          child: Icon(
                            Icons.arrow_downward_rounded,
                            color: AppColors.accent,
                          ),
                        ),
                        AppTexts.caption2(
                          'SAY THIS',
                          context,
                          color: AppColors.primary,
                        ),
                        AppTexts.title1(
                          'I’m swamped.',
                          context,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacings.elementSpacing),
                  AppCard(
                    child: Column(
                      children: [
                        OnboardingSummaryRow(
                          label: 'Your focus',
                          value: _goalLabel(goal),
                        ),
                        OnboardingSummaryRow(
                          label: 'Daily habit',
                          value: '$minutes min',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
    );
  }
}

String _goalLabel(String goal) => switch (goal) {
  'social' => 'Natural conversations',
  'interview' => 'Job interviews',
  'all' => 'Every situation',
  _ => 'Professional English',
};
