import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';
import '../widgets/texts/app_texts.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacings.elementSpacingSmall),
        ],
        Flexible(
          child: AppTexts.button(
            label,
            context,
            color: variant == AppButtonVariant.primary
                ? Colors.white
                : AppColors.primaryLight,
          ),
        ),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: AppSpacings.buttonBorderRadius,
    );
    final style = switch (variant) {
      AppButtonVariant.primary => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: shape,
        elevation: 0,
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.controlPaddingHorizontal,
          vertical: AppSpacings.controlPaddingVertical,
        ),
      ),
      AppButtonVariant.secondary => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        shape: shape,
        side: BorderSide(color: AppColors.primaryLightWith(0.35)),
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.controlPaddingHorizontal,
          vertical: AppSpacings.controlPaddingVertical,
        ),
      ),
      AppButtonVariant.ghost => TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        shape: shape,
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.elementSpacing,
          vertical: AppSpacings.compactControlPaddingVertical,
        ),
      ),
    };

    return switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    };
  }
}
