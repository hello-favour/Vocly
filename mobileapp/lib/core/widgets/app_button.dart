import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

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
        if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    final style = switch (variant) {
      AppButtonVariant.primary => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: shape,
        minimumSize: const Size.fromHeight(48),
      ),
      AppButtonVariant.secondary => OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: shape,
        side: const BorderSide(color: AppColors.primary),
        minimumSize: const Size.fromHeight(48),
      ),
      AppButtonVariant.ghost => TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: shape,
        minimumSize: const Size.fromHeight(44),
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
