import 'package:flutter/material.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacings.cardPadding),
    this.color,
    this.selected = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? (selected ? AppColors.cardSelected : AppColors.card),
        borderRadius: AppSpacings.cardBorderRadius,
        border: Border.all(
          color: selected ? AppColors.borderSelected : AppColors.border,
          width: AppSpacings.cardOutlineWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: selected ? 0.08 : 0.05),
            blurRadius: selected ? 22 : 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
