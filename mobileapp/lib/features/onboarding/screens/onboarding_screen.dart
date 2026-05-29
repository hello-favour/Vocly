import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../session/app_session_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final pageController = PageController();
  final nameController = TextEditingController();
  String level = 'intermediate';
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
          children: [
            _StepScaffold(
              title: 'What is your name?',
              onNext: _next,
              child: AppTextField(controller: nameController, label: 'Name'),
            ),
            _ChoiceStep(
              title: 'What is your current level?',
              value: level,
              choices: const {
                'beginner': 'Beginner',
                'intermediate': 'Intermediate',
                'advanced': 'Advanced',
              },
              onChanged: (value) => setState(() => level = value),
              onNext: _next,
            ),
            _ChoiceStep(
              title: 'What is your main goal?',
              value: goal,
              choices: const {
                'professional': 'Professional',
                'academic': 'Academic',
                'social': 'Social',
                'travel': 'Travel',
              },
              onChanged: (value) => setState(() => goal = value),
              onNext: _next,
            ),
            _ChoiceStep(
              title: 'How many minutes can you practice daily?',
              value: '$minutes',
              choices: const {'5': '5 min', '10': '10 min', '15': '15 min'},
              onChanged: (value) => setState(() => minutes = int.parse(value)),
              onNext: _next,
            ),
            _StepScaffold(
              title: 'Your daily coach is ready',
              buttonLabel: 'Start today’s lesson',
              onNext: () async {
                await ref
                    .read(appSessionProvider.notifier)
                    .completeOnboarding(
                      displayName: nameController.text.trim().isEmpty
                          ? 'Friend'
                          : nameController.text.trim(),
                      skillLevel: level,
                      goal: goal,
                      dailyGoalMinutes: minutes,
                    );
                if (context.mounted) context.go('/home/lessons');
              },
              child: const Icon(
                Icons.workspace_premium,
                size: 88,
                color: Colors.amber,
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

class _StepScaffold extends StatelessWidget {
  const _StepScaffold({
    required this.title,
    required this.child,
    required this.onNext,
    this.buttonLabel = 'Continue',
  });

  final String title;
  final Widget child;
  final VoidCallback onNext;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        const SizedBox(height: 48),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        AppCard(child: child),
        const SizedBox(height: 24),
        AppButton(
          label: buttonLabel,
          icon: Icons.arrow_forward,
          onPressed: onNext,
        ),
      ],
    );
  }
}

class _ChoiceStep extends StatelessWidget {
  const _ChoiceStep({
    required this.title,
    required this.value,
    required this.choices,
    required this.onChanged,
    required this.onNext,
  });

  final String title;
  final String value;
  final Map<String, String> choices;
  final ValueChanged<String> onChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _StepScaffold(
      title: title,
      onNext: onNext,
      child: Column(
        children: choices.entries.map((entry) {
          final selected = entry.key == value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: selected
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                  : null,
              leading: Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              title: Text(entry.value),
              onTap: () => onChanged(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
