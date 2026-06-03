import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/extensions.dart';
import '../constants/app_colors.dart';
import '../theme/app_spacing.dart' as theme_spacing;

enum SnackBarType {
  success,
  error,
  info,
  warning;

  Color get getColor {
    switch (this) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.danger;
      case SnackBarType.info:
        return AppColors.surface;
      case SnackBarType.warning:
        return AppColors.danger.withValues(alpha: 0.1);
    }
  }

  IconData get getIcon {
    switch (this) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.info:
        return Icons.info;
      case SnackBarType.warning:
        return Icons.warning;
    }
  }

  Color get getTextColor {
    switch (this) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.error:
        return AppColors.danger;
      case SnackBarType.info:
        return AppColors.surface;
      case SnackBarType.warning:
        return AppColors.danger;
    }
  }
}

class AppSnackbar {
  AppSnackbar._();

  static void showSnackBar(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    bool positionOnTop = true,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onTap,
    Widget? trailing,
    bool autoDismiss = true,
  }) {
    return DelightToastBar(
      autoDismiss: autoDismiss,
      snackbarDuration: duration,
      position: positionOnTop
          ? DelightSnackbarPosition.top
          : DelightSnackbarPosition.bottom,
      builder: (context) => DecoratedBox(
        decoration: BoxDecoration(
          color: type.getColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset.zero,
              color: AppColors.textPrimary.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.all(4),
          horizontalTitleGap: 5,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(type.getIcon, size: 28, color: type.getTextColor),
          ),
          trailing: trailing,
          title: Text(message, style: Theme.of(context).textTheme.titleLarge),
          onTap: onTap,
        ),
      ).padSymmetric(horizontal: theme_spacing.AppSpacings.elementSpacing),
    ).show(context);
  }
}
