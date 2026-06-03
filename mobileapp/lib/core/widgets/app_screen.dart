import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../theme/app_spacing.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacings.screenPadding,
      vertical: AppSpacings.elementSpacingLarge,
    ),
    this.safeArea = false,
    this.background = AppColors.background,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final bool safeArea;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final view = ListView(padding: padding, children: children);
    return ColoredBox(
      color: background,
      child: safeArea ? SafeArea(child: view) : view,
    );
  }
}
