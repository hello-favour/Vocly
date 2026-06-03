import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/texts/app_texts.dart';
import '../../session/app_session_provider.dart';
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
  final nameController = TextEditingController();
  int page = 0;
  String level = 'beginner';
  String goal = 'professional';
  int minutes = 10;

  @override
  void dispose() {
    pageController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) => setState(() => page = value),
          children: [
            OnboardingStepScaffold(
              step: 1,
              title: 'What’s your name?',
              subtitle: 'We’ll personalise your experience',
              onNext: _next,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    controller: nameController,
                    label: 'Your name',
                    hint: 'Paul',
                  ),
                  const SizedBox(height: AppSpacings.iconGap),
                  AppTexts.caption1(
                    'This is just for personalisation. You can change it anytime in settings.',
                    context,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 2,
              title: 'What’s your level?',
              subtitle: 'Be honest — we’ll match your lessons',
              onNext: _next,
              child: Column(
                children: [
                  OnboardingChoiceTile(
                    icon: Icons.eco_outlined,
                    title: 'Beginner',
                    subtitle: 'I make many mistakes',
                    selected: level == 'beginner',
                    onTap: () => setState(() => level = 'beginner'),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Intermediate',
                    subtitle: 'I can hold a conversation',
                    selected: level == 'intermediate',
                    onTap: () => setState(() => level = 'intermediate'),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.rocket_launch_outlined,
                    title: 'Advanced',
                    subtitle: 'I want to sound more polished',
                    selected: level == 'advanced',
                    onTap: () => setState(() => level = 'advanced'),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 3,
              title: 'What’s your main goal?',
              subtitle: 'Choose what matters most to you',
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
                    label: 'Professional',
                    selected: goal == 'professional',
                    onTap: () => setState(() => goal = 'professional'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.school_outlined,
                    label: 'Academic',
                    selected: goal == 'academic',
                    onTap: () => setState(() => goal = 'academic'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.groups_outlined,
                    label: 'Social life',
                    selected: goal == 'social',
                    onTap: () => setState(() => goal = 'social'),
                  ),
                  OnboardingGoalCard(
                    icon: Icons.flight_takeoff,
                    label: 'Travel',
                    selected: goal == 'travel',
                    onTap: () => setState(() => goal = 'travel'),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 4,
              title: 'Daily practice time?',
              subtitle: 'Pick what fits your schedule',
              onNext: _next,
              child: Column(
                children: [
                  OnboardingChoiceTile(
                    icon: Icons.schedule,
                    title: '5 minutes',
                    subtitle: 'Quick daily habit',
                    selected: minutes == 5,
                    onTap: () => setState(() => minutes = 5),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.star_border,
                    title: '10 minutes',
                    subtitle: 'Recommended for most',
                    selected: minutes == 10,
                    onTap: () => setState(() => minutes = 10),
                  ),
                  OnboardingChoiceTile(
                    icon: Icons.bolt_outlined,
                    title: '15 minutes',
                    subtitle: 'Serious improvement',
                    selected: minutes == 15,
                    onTap: () => setState(() => minutes = 15),
                  ),
                ],
              ),
            ),
            OnboardingStepScaffold(
              step: 5,
              title: 'You’re all set!',
              subtitle: 'Your personalised English journey starts now',
              buttonLabel: 'Start learning',
              onNext: () async {
                await ref
                    .read(appSessionProvider.notifier)
                    .completeOnboarding(
                      displayName: nameController.text.trim().isEmpty
                          ? 'Paul'
                          : nameController.text.trim(),
                      skillLevel: level,
                      goal: goal,
                      dailyGoalMinutes: minutes,
                    );
                if (context.mounted) context.go(AppRoutes.lessonsTab);
              },
              child: Column(
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.success,
                      size: 46,
                    ),
                  ),
                  const SizedBox(height: AppSpacings.sectionSpacing),
                  AppCard(
                    child: Column(
                      children: [
                        OnboardingSummaryRow(label: 'Level', value: level),
                        OnboardingSummaryRow(label: 'Goal', value: goal),
                        OnboardingSummaryRow(
                          label: 'Daily target',
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
