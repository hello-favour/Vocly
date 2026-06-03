import 'package:flutter/material.dart';
import '../../theme/text_theme.dart';

@immutable
class AppTexts {
  const AppTexts._();

  static Widget largeTitle(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.displayLarge,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget title1(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.displayMedium,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget title2(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.displaySmall,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget title3(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.headlineMedium,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget headline(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.headlineSmall,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget body(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    FontStyle? fontStyle,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.bodyMedium,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
    fontStyle: fontStyle,
  );

  static Widget bodySecondary(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.bodyLarge,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget caption1(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    FontStyle? fontStyle,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.bodySmall,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
    fontStyle: fontStyle,
  );

  static Widget caption2(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.labelSmall,
    color: color,
    fontWeight: fontWeight,
    center: center,
    fontSize: fontSize,
    overflow: overflow,
    maxLines: maxLines,
  );

  static Widget button(
    String text,
    BuildContext context, {
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    bool center = false,
  }) => _text(
    text,
    context,
    Theme.of(context).textTheme.labelLarge,
    color: color,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? AppTextThemes.subheadline,
    center: center,
  );

  static Widget _text(
    String text,
    BuildContext context,
    TextStyle? base, {
    Color? color,
    FontWeight? fontWeight,
    bool center = false,
    double? fontSize,
    TextOverflow? overflow,
    int? maxLines,
    FontStyle? fontStyle,
  }) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
      style: base?.copyWith(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
        letterSpacing: 0,
      ),
    );
  }
}
