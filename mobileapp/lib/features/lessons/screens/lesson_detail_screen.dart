import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_stat_card.dart';
import 'package:mobileapp/core/widgets/page_dots.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/lessons/providers/lessons_provider.dart';
import 'package:mobileapp/features/lessons/widgets/grammar_page_card.dart';
import 'package:mobileapp/features/lessons/widgets/lesson_page_card.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class LessonDetailScreen extends ConsumerStatefulWidget {
  const LessonDetailScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends ConsumerState<LessonDetailScreen> {
  final controller = PageController();
  int page = 0;
  bool complete = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lesson = ref.watch(lessonByIdProvider(widget.lessonId));
    if (lesson == null) {
      return Scaffold(
        body: Center(child: AppTexts.body('Lesson not found', context)),
      );
    }

    if (complete) {
      final session =
          ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
      return Scaffold(
        appBar: AppBar(title: const Text('Lesson complete')),
        body: AppScreen(
          padding: const EdgeInsets.all(AppSpacings.screenPadding),
          children: [
            const SizedBox(height: AppSpacings.pageSpacing),
            Center(
              child: Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.warning.withValues(alpha: 0.15),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: AppColors.warning,
                  size: 46,
                ),
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            AppTexts.title2(
              'Day ${session.streakCount == 0 ? 12 : session.streakCount} streak!',
              context,
              center: true,
            ),
            const SizedBox(height: AppSpacings.elementSpacingSmall),
            AppTexts.body(
              'You completed today’s lesson. Keep it up tomorrow!',
              context,
              color: AppColors.textTertiary,
              center: true,
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            Row(
              children: [
                Expanded(
                  child: AppStatCard(
                    value: '+10',
                    label: 'Coins earned',
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppSpacings.elementSpacing),
                Expanded(
                  child: AppStatCard(
                    value: '12',
                    label: 'Day streak',
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: AppSpacings.elementSpacing),
                Expanded(
                  child: AppStatCard(
                    value: '3',
                    label: 'Words learned',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacings.sectionSpacing),
            AppButton(
              label: 'Practice writing',
              onPressed: () => context.go(AppRoutes.writingTab),
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            AppButton(
              label: 'Back to home',
              variant: AppButtonVariant.secondary,
              onPressed: () => context.go(AppRoutes.lessonsTab),
            ),
          ],
        ),
      );
    }

    final cards = [
      LessonPageCard(
        pill: const AppPill(label: 'Word of the day'),
        title: lesson.word,
        body: lesson.wordDefinition,
        accent: '"${lesson.wordExample}"',
      ),
      LessonPageCard(
        pill: const AppPill(
          label: 'Phrase of the day',
          tone: AppPillTone.amber,
        ),
        title: '"${lesson.phrase}"',
        body: lesson.phraseMeaning,
        accent: 'Use in: business meetings, direct conversations',
      ),
      GrammarPageCard(rule: lesson.grammarRule, example: lesson.grammarExample),
      const LessonPageCard(
        pill: AppPill(label: 'Practice prompt', tone: AppPillTone.green),
        title: 'Use today’s word',
        body: 'Write one sentence with the word and check it with AI.',
        accent: 'This turns passive learning into active communication.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          page == 1
              ? 'Today’s lesson'
              : page == 2
              ? 'Grammar rule'
              : lesson.title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacings.screenPadding),
            child: AppTexts.caption1(
              '${page + 1} / ${cards.length}',
              context,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacings.elementSpacing),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) => setState(() => page = value),
                children: cards,
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            PageDots(current: page, total: cards.length),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            Row(
              children: [
                if (page > 0) ...[
                  Expanded(
                    child: AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.secondary,
                      onPressed: () => controller.previousPage(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacings.iconGap),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: page == cards.length - 1
                        ? 'Complete lesson'
                        : 'Next',
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
                      ref
                          .read(appSessionProvider.notifier)
                          .markActivity(coins: 10);
                      setState(() => complete = true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
