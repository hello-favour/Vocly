import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class ProgressDayLabel extends StatelessWidget {
  const ProgressDayLabel(this.label, {super.key, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AppTexts.caption1(
      label,
      context,
      color: active ? AppColors.primaryLight : AppColors.textTertiary,
      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
    );
  }
}
