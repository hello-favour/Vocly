import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/text_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final int minLines;
  final int maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontFamily: AppFonts.body,
        fontFamilyFallback: AppFonts.fallbackFonts,
        fontSize: AppTextThemes.callout,
        letterSpacing: 0,
      ),
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
