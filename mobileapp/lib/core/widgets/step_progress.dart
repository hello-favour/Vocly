import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';

class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++)
          Expanded(
            child: Container(
              height: AppSpacings.elementSpacingTiny,
              margin: EdgeInsets.only(
                right: i == total - 1 ? 0 : AppSpacings.elementSpacingSmall,
              ),
              decoration: BoxDecoration(
                color: i < current
                    ? AppColors.primary
                    : AppColors.whiteWith(0.1),
                borderRadius: AppSpacings.chipBorderRadius,
              ),
            ),
          ),
      ],
    );
  }
}
