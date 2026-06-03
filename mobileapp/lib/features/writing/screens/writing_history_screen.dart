import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/features/writing/widgets/writing_history_item.dart';
import 'package:mobileapp/features/writing/widgets/writing_history_tabs.dart';

class WritingHistoryScreen extends StatelessWidget {
  const WritingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Writing history')),
      body: AppScreen(
        children: [
          WritingHistoryTabs(),
          SizedBox(height: AppSpacings.elementSpacing),
          WritingHistoryItem(
            score: 84,
            text: 'I have been working here...',
            meta: 'Today · 0 issues',
            tone: 'Formal',
          ),
          SizedBox(height: AppSpacings.elementSpacing),
          WritingHistoryItem(
            score: 61,
            text: 'Dear sir, I am writing to...',
            meta: 'Yesterday · 3 issues',
            tone: 'Informal',
          ),
          SizedBox(height: AppSpacings.elementSpacing),
          WritingHistoryItem(
            score: 44,
            text: 'The meeting was went very...',
            meta: 'Mon · 5 issues',
            tone: 'Neutral',
          ),
        ],
      ),
    );
  }
}
