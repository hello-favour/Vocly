import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_loader.dart';
import '../../session/app_session_provider.dart';
import '../providers/progress_provider.dart';

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
      data: (stats) => ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('Progress', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: _Stat(
                    value: '${session.streakCount}',
                    label: 'Day streak',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  child: _Stat(
                    value: '${stats.wordsLearned}',
                    label: 'Words learned',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppCard(
            child: _MiniChart(
              title: 'Writing score',
              values: stats.writingScores,
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: _MiniChart(
              title: 'Pronunciation score',
              values: stats.pronunciationScores,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        Text(label),
      ],
    );
  }
}

class _MiniChart extends StatelessWidget {
  const _MiniChart({required this.title, required this.values});
  final String title;
  final List<int> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < values.length; i++)
                        FlSpot(i.toDouble(), values[i].toDouble()),
                    ],
                    isCurved: true,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
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
