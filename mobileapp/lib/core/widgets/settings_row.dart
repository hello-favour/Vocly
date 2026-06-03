import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import 'texts/app_texts.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.danger = false,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.textSecondary;
    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacings.defaultBorderRadiusTextField,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacings.elementSpacing,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.caption1(
                    title,
                    context,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacings.elementSpacingTiny),
                    AppTexts.caption1(
                      subtitle!,
                      context,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                Icon(
                  danger ? Icons.logout : Icons.chevron_right,
                  size: 18,
                  color: danger ? AppColors.danger : AppColors.textTertiary,
                ),
          ],
        ),
      ),
    );
  }
}
