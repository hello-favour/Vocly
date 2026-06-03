import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';

class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < total; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: i == current
                ? AppSpacings.elementSpacing
                : AppSpacings.elementSpacingSmall,
            height: AppSpacings.elementSpacingSmall,
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacings.elementSpacingTiny,
            ),
            decoration: BoxDecoration(
              color: i == current
                  ? AppColors.primaryLight
                  : AppColors.whiteWith(0.18),
              borderRadius: AppSpacings.chipBorderRadius,
            ),
          ),
      ],
    );
  }
}
