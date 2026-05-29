import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_loader.dart';
import '../providers/lessons_provider.dart';

class LessonsScreen extends ConsumerWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(todaysLessonsProvider);

    return lessons.when(
      loading: () => const AppLoader(),
      error: (error, stackTrace) =>
          Center(child: Text('Could not load lessons: $error')),
      data: (items) => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            'Today’s lesson',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'One word, one phrase, one grammar move. Ten focused minutes.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          for (final lesson in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Word: ${lesson.word}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(lesson.wordDefinition),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Open lesson',
                      icon: Icons.arrow_forward,
                      onPressed: () => context.push('/lessons/${lesson.id}'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
