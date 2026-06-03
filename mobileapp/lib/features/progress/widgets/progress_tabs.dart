import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/features/progress/widgets/tab_progress.dart';

class ProgressTabs extends StatelessWidget {
  const ProgressTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacings.elementSpacingTiny),
      decoration: BoxDecoration(
        color: AppColors.whiteWith(0.05),
        borderRadius: AppSpacings.defaultBorderRadiusTextField,
      ),
      child: Row(
        children: const [
          TabProgress(label: 'Week', active: true),
          TabProgress(label: 'Month'),
          TabProgress(label: 'All time'),
        ],
      ),
    );
  }
}
