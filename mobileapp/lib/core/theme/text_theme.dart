import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppFonts {
  static const String heading = 'Fraunces';
  static const String body = 'DM Sans';

  static const List<String> fallbackFonts = [
    'SF Pro Display',
    'Roboto',
    'Arial',
    'sans-serif',
  ];
}

class AppTextThemes {
  AppTextThemes._();

  static const double largeTitle = 44;
  static const double title1 = 36;
  static const double title2 = 30;
  static const double title3 = 26;
  static const double headline = 22;
  static const double body = 19;
  static const double callout = 18;
  static const double subheadline = 17;
  static const double footnote = 16;
  static const double caption1 = 15;
  static const double caption2 = 14;
  static const double micro = 13;

  static TextStyle get chipLabel => GoogleFonts.dmSans(
    fontSize: caption2,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.6,
    height: 1.18,
  );

  static final TextTheme mobileTextThemeLight = TextTheme(
    displayLarge: GoogleFonts.fraunces(
      fontSize: largeTitle,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.21,
    ),
    displayMedium: GoogleFonts.fraunces(
      fontSize: title1,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      height: 1.21,
    ),
    displaySmall: GoogleFonts.fraunces(
      fontSize: title2,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.27,
    ),
    headlineMedium: GoogleFonts.fraunces(
      fontSize: title3,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineSmall: GoogleFonts.dmSans(
      fontSize: headline,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.29,
    ),
    titleLarge: GoogleFonts.dmSans(
      fontSize: callout,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.31,
    ),
    titleMedium: GoogleFonts.dmSans(
      fontSize: subheadline,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.33,
    ),
    titleSmall: GoogleFonts.dmSans(
      fontSize: footnote,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.38,
    ),
    bodyLarge: GoogleFonts.dmSans(
      fontSize: body,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.29,
    ),
    bodyMedium: GoogleFonts.dmSans(
      fontSize: subheadline,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ),
    bodySmall: GoogleFonts.dmSans(
      fontSize: caption1,
      color: AppColors.textTertiary,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ),
    labelLarge: GoogleFonts.dmSans(
      fontSize: subheadline,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.dmSans(
      fontSize: caption2,
      color: AppColors.textTertiary,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.18,
    ),
  );
}
