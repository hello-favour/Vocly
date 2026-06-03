import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class ProgressBarChart extends StatelessWidget {
  const ProgressBarChart({super.key, required this.values});

  final List<int> values;

  @override
  Widget build(BuildContext context) {
    final chartValues = values.isEmpty ? [55, 60, 52, 72, 65, 80, 88] : values;
    return SizedBox(
      height: 76,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < chartValues.length; i++)
            Expanded(
              child: Container(
                height: chartValues[i] * 0.5,
                margin: EdgeInsets.only(
                  right: i == chartValues.length - 1
                      ? 0
                      : AppSpacings.elementSpacingSmall,
                ),
                decoration: BoxDecoration(
                  color: i == chartValues.length - 1
                      ? AppColors.primary
                      : AppColors.primaryWith(0.3),
                  borderRadius: AppSpacings.defaultBorderRadiusTextField,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
