import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/text_theme.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacings.elementSpacingLarge,
        bottom: AppSpacings.elementSpacing,
        left: AppSpacings.elementSpacingTiny,
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontFamily: AppFonts.body,
          fontFamilyFallback: AppFonts.fallbackFonts,
          color: AppColors.textTertiary,
          fontSize: AppTextThemes.caption2,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}
