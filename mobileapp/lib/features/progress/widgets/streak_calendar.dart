import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final active = {0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13};
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 14,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: AppSpacings.elementSpacingSmall,
        crossAxisSpacing: AppSpacings.elementSpacingSmall,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(
          color: active.contains(index) ? AppColors.primary : AppColors.border,
          borderRadius: AppSpacings.defaultBorderRadiusTextField,
        ),
      ),
    );
  }
}
