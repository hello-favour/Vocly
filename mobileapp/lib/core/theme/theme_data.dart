import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_spacing.dart';
import 'colors.dart';
import 'text_theme.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData themeLight = ThemeData(
    useMaterial3: true,
    fontFamily: AppFonts.body,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    canvasColor: AppColors.background,
    hintColor: AppColors.textTertiary,
    splashColor: AppColors.primaryWith(0.12),
    highlightColor: AppColors.primaryWith(0.08),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primaryLight,
      onSecondary: Colors.white,
      tertiary: AppColors.accent,
      onTertiary: AppColors.ink,
      error: AppColors.danger,
      onError: Colors.white,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
    ),
    textTheme: AppTextThemes.mobileTextThemeLight,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: GoogleFonts.dmSans(
        fontSize: AppTextThemes.headline,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacings.cardBorderRadius,
        side: const BorderSide(
          color: AppColors.border,
          width: AppSpacings.cardOutlineWidth,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: AppSpacings.outlineWidth,
      space: AppSpacings.outlineWidth,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 76,
      backgroundColor: AppColors.background,
      indicatorColor: AppColors.primaryWith(0.2),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontFamily: AppFonts.body,
          fontFamilyFallback: AppFonts.fallbackFonts,
          fontSize: AppTextThemes.caption1,
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryLight
              : AppColors.textTertiary,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.w400,
          letterSpacing: 0,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryLight
              : AppColors.textTertiary,
          size: 26,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      labelStyle: TextStyle(
        color: AppColors.textTertiary,
        fontFamily: AppFonts.body,
        fontFamilyFallback: AppFonts.fallbackFonts,
        fontSize: AppTextThemes.caption1,
      ),
      hintStyle: TextStyle(
        color: AppColors.textTertiary,
        fontFamily: AppFonts.body,
        fontFamilyFallback: AppFonts.fallbackFonts,
        fontSize: AppTextThemes.subheadline,
      ),
      counterStyle: TextStyle(
        color: AppColors.textTertiary,
        fontFamily: AppFonts.body,
        fontFamilyFallback: AppFonts.fallbackFonts,
        fontSize: AppTextThemes.caption1,
      ),
      border: AppSpacings.outLineBorder,
      enabledBorder: AppSpacings.outLineBorder,
      focusedBorder: AppSpacings.focusedOutLineBorder,
      disabledBorder: AppSpacings.disabledOutLineBorder,
      errorBorder: AppSpacings.errorLineBorder,
      focusedErrorBorder: AppSpacings.errorFocusedBorder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacings.cardPadding,
        vertical: AppSpacings.cardPadding,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.primaryWith(0.35),
        disabledForegroundColor: Colors.white70,
        elevation: 0,
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.controlPaddingHorizontal,
          vertical: AppSpacings.controlPaddingVertical,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacings.buttonBorderRadius,
        ),
        textStyle: GoogleFonts.dmSans(
          fontSize: AppTextThemes.subheadline,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        minimumSize: const Size.fromHeight(60),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacings.controlPaddingHorizontal,
          vertical: AppSpacings.controlPaddingVertical,
        ),
        side: BorderSide(
          color: AppColors.primaryLightWith(0.35),
          width: AppSpacings.outlineWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacings.buttonBorderRadius,
        ),
        textStyle: GoogleFonts.dmSans(
          fontSize: AppTextThemes.subheadline,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        textStyle: GoogleFonts.dmSans(
          fontSize: AppTextThemes.subheadline,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    ),
  );
}
