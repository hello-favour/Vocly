import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_loader.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_stat_card.dart';
import 'package:mobileapp/core/widgets/page_dots.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/lessons/providers/lessons_provider.dart';

class LessonsScreen extends ConsumerWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(todaysLessonsProvider);

    return lessons.when(
      loading: () => const AppLoader(),
      error: (error, stackTrace) => Center(
        child: AppTexts.body('Could not load lessons: $error', context),
      ),
      data: (items) {
        final lesson = items.first;
        return AppScreen(
          children: [
            AppCard(
              color: AppColors.primaryWith(0.18),
              padding: const EdgeInsets.all(AppSpacings.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const AppPill(label: 'Word of the day'),
                      const Spacer(),
                      AppTexts.caption1(
                        '1 / 4',
                        context,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingLarge),
                  AppTexts.title1(lesson.word, context),
                  const SizedBox(height: AppSpacings.elementSpacing),
                  AppTexts.body(
                    lesson.wordDefinition,
                    context,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacings.elementSpacing),
                  AppTexts.body(
                    '"${lesson.wordExample}"',
                    context,
                    color: AppColors.primaryLight,
                    fontStyle: FontStyle.italic,
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingLarge),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightWith(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryLightWith(0.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: AppColors.primaryLight,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            const PageDots(current: 0, total: 4),
            const SectionLabel('Today’s summary'),
            const Row(
              children: [
                Expanded(
                  child: AppStatCard(value: '1', label: 'Lessons'),
                ),
                SizedBox(width: AppSpacings.elementSpacing),
                Expanded(
                  child: AppStatCard(value: '3', label: 'AI checks'),
                ),
                SizedBox(width: AppSpacings.elementSpacing),
                Expanded(
                  child: AppStatCard(
                    value: '74',
                    label: 'Avg score',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            AppButton(
              label: 'Open today’s lesson',
              onPressed: () => context.push(AppRoutes.lesson(lesson.id)),
            ),
          ],
        );
      },
    );
  }
}
