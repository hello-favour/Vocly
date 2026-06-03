import 'package:flutter/material.dart';
import 'colors.dart';

class AppSpacings {
  AppSpacings._();

  static const double webWidth = 1080;

  static const double screenPadding = 24;
  static const double cardPadding = 22;
  static const double elementSpacing = 14;
  static const double elementSpacingSmall = 8;
  static const double elementSpacingTiny = 4;
  static const double elementSpacingLarge = 20;
  static const double sectionSpacing = 28;
  static const double pageSpacing = 34;
  static const double iconGap = 12;
  static const double controlPaddingHorizontal = 20;
  static const double controlPaddingVertical = 16;
  static const double compactControlPaddingVertical = 12;

  static const double radius = 4;
  static const double outlineWidth = 0.5;
  static const double cardOutlineWidth = 0.5;

  static const BorderRadius cardBorderRadius = BorderRadius.all(
    Radius.circular(20),
  );

  static const BorderRadius buttonBorderRadius = BorderRadius.all(
    Radius.circular(18),
  );

  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(18),
  );

  static const BorderRadius defaultBorderRadiusTextField = BorderRadius.all(
    Radius.circular(16),
  );

  static const BorderRadius largeBorderRadius = BorderRadius.all(
    Radius.circular(radius * 3),
  );

  static const BorderRadius chipBorderRadius = BorderRadius.all(
    Radius.circular(999),
  );

  static const BorderRadius defaultCircularRadius = BorderRadius.all(
    Radius.circular(999),
  );

  static const OutlineInputBorder outLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadiusTextField,
    borderSide: BorderSide(color: AppColors.border, width: outlineWidth),
  );

  static const OutlineInputBorder focusedOutLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadiusTextField,
    borderSide: BorderSide(color: AppColors.primaryLight, width: 1),
  );

  static const OutlineInputBorder disabledOutLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadiusTextField,
    borderSide: BorderSide(color: AppColors.border, width: outlineWidth),
  );

  static const OutlineInputBorder errorLineBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadiusTextField,
    borderSide: BorderSide(color: AppColors.danger, width: 1),
  );

  static const OutlineInputBorder errorFocusedBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadiusTextField,
    borderSide: BorderSide(color: AppColors.danger, width: 1),
  );
}
