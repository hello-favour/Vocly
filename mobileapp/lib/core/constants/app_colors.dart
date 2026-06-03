import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6D1028);
  static const primaryLight = Color(0xFF9F2445);
  static const accent = Color(0xFFC99045);
  static const background = Color(0xFFFFFCFA);
  static const backgroundDeep = Color(0xFFF8EEF1);
  static const ink = Color(0xFF241218);
  static const surface = Color(0xFFFFFFFF);
  static const card = Color(0xFFFFFFFF);
  static const cardSelected = Color(0xFFFFEEF3);
  static const border = Color(0x1F6D1028);
  static const borderSelected = Color(0xCC6D1028);
  static const textPrimary = Color(0xFF241218);
  static const textSecondary = Color(0xCC3B222A);
  static const textTertiary = Color(0x995B3A45);
  static const success = Color(0xFF13865E);
  static const warning = Color(0xFFC99045);
  static const danger = Color(0xFFD64045);
  static const info = Color(0xFF7C4D8E);

  static Color whiteWith(double opacity) => ink.withValues(alpha: opacity);
  static Color primaryWith(double opacity) =>
      primary.withValues(alpha: opacity);
  static Color primaryLightWith(double opacity) =>
      primaryLight.withValues(alpha: opacity);
}
