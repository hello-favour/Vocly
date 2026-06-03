import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/widgets/app_loader.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_stat_card.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/streak_chip.dart';
import 'package:mobileapp/features/progress/providers/progress_provider.dart';
import 'package:mobileapp/features/progress/widgets/progress_bar_chart.dart';
import 'package:mobileapp/features/progress/widgets/progress_day_label.dart';
import 'package:mobileapp/features/progress/widgets/progress_legend.dart';
import 'package:mobileapp/features/progress/widgets/progress_tabs.dart';
import 'package:mobileapp/features/progress/widgets/streak_calendar.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressProvider);
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

    return progress.when(
      loading: () => const AppLoader(),
      error: (error, stackTrace) => Center(child: Text('$error')),
      data: (stats) => AppScreen(
        children: [
          Row(
            children: [
              Text(
                'Your progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              StreakChip(
                session.streakCount == 0 ? 12 : session.streakCount,
                suffix: ' days',
              ),
            ],
          ),
          const SizedBox(height: 12),
          const ProgressTabs(),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: AppStatCard(value: '47', label: 'Words learned'),
              ),
              SizedBox(width: 8),
              Expanded(
                child: AppStatCard(value: '31', label: 'AI checks'),
              ),
              SizedBox(width: 8),
              Expanded(
                child: AppStatCard(
                  value: '72',
                  label: 'Avg score',
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SectionLabel('Writing scores'),
          ProgressBarChart(values: stats.writingScores),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressDayLabel('Mon'),
              ProgressDayLabel('Tue'),
              ProgressDayLabel('Wed'),
              ProgressDayLabel('Thu'),
              ProgressDayLabel('Fri'),
              ProgressDayLabel('Sat'),
              ProgressDayLabel('Sun', active: true),
            ],
          ),
          const SectionLabel('Streak calendar'),
          const StreakCalendar(),
          const SizedBox(height: 10),
          Row(
            children: [
              ProgressLegend(color: AppColors.primary, label: 'Active'),
              SizedBox(width: 18),
              ProgressLegend(color: AppColors.border, label: 'Missed'),
            ],
          ),
        ],
      ),
    );
  }
}
