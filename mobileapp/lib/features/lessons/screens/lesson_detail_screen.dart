import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../session/app_session_provider.dart';
import '../providers/lessons_provider.dart';

class LessonDetailScreen extends ConsumerStatefulWidget {
  const LessonDetailScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends ConsumerState<LessonDetailScreen> {
  final controller = PageController();
  int page = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = ref.watch(lessonByIdProvider(widget.lessonId));
    if (lesson == null) {
      return const Scaffold(body: Center(child: Text('Lesson not found')));
    }

    final cards = [
      _LessonPage(
        title: 'Word of the day',
        headline: lesson.word,
        body: '${lesson.wordDefinition}\n\n${lesson.wordExample}',
      ),
      _LessonPage(
        title: 'Phrase of the day',
        headline: lesson.phrase,
        body: lesson.phraseMeaning,
      ),
      _LessonPage(
        title: 'Grammar rule',
        headline: lesson.grammarRule,
        body: lesson.grammarExample,
      ),
      const _LessonPage(
        title: 'Practice prompt',
        headline: 'Use today’s word',
        body: 'Write one sentence with the word and check it with AI.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) => setState(() => page = value),
                children: cards,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: (page + 1) / cards.length),
            const SizedBox(height: 12),
            AppButton(
              label: page == cards.length - 1 ? 'Complete lesson' : 'Next card',
              icon: page == cards.length - 1
                  ? Icons.check
                  : Icons.arrow_forward,
              onPressed: () async {
                if (page < cards.length - 1) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                  );
                  return;
                }
                await ref
                    .read(lessonsRepositoryProvider)
                    .completeLesson(lesson.id);
                ref.read(appSessionProvider.notifier).markActivity(coins: 10);
                if (context.mounted) context.go('/home/writing');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonPage extends StatelessWidget {
  const _LessonPage({
    required this.title,
    required this.headline,
    required this.body,
  });

  final String title;
  final String headline;
  final String body;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 16),
          Text(headline, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(body, style: Theme.of(context).textTheme.bodyLarge),
          const Spacer(),
          const Icon(Icons.volume_up_outlined),
        ],
      ),
    );
  }
}
