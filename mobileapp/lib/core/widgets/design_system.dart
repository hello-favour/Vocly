// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
// import '../theme/app_spacing.dart';
// import '../theme/text_theme.dart';
// import 'texts/app_texts.dart';

// class AppScreen extends StatelessWidget {
//   const AppScreen({
//     super.key,
//     required this.children,
//     this.padding = const EdgeInsets.symmetric(
//       horizontal: AppSpacings.screenPadding,
//       vertical: 14,
//     ),
//     this.safeArea = false,
//     this.background = AppColors.background,
//   });

//   final List<Widget> children;
//   final EdgeInsetsGeometry padding;
//   final bool safeArea;
//   final Color background;

//   @override
//   Widget build(BuildContext context) {
//     final view = ListView(padding: padding, children: children);
//     return ColoredBox(
//       color: background,
//       child: safeArea ? SafeArea(child: view) : view,
//     );
//   }
// }

// class SectionLabel extends StatelessWidget {
//   const SectionLabel(this.label, {super.key});

//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4),
//       child: Text(
//         label.toUpperCase(),
//         style: const TextStyle(
//           fontFamily: AppFonts.body,
//           fontFamilyFallback: AppFonts.fallbackFonts,
//           color: AppColors.textTertiary,
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//           letterSpacing: 0.7,
//         ),
//       ),
//     );
//   }
// }

// enum AppPillTone { violet, green, amber, red }

// class AppPill extends StatelessWidget {
//   const AppPill({
//     super.key,
//     required this.label,
//     this.icon,
//     this.tone = AppPillTone.violet,
//   });

//   final String label;
//   final IconData? icon;
//   final AppPillTone tone;

//   @override
//   Widget build(BuildContext context) {
//     final color = switch (tone) {
//       AppPillTone.violet => AppColors.primaryLight,
//       AppPillTone.green => AppColors.success,
//       AppPillTone.amber => AppColors.warning,
//       AppPillTone.red => AppColors.danger,
//     };
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.18),
//         borderRadius: AppSpacings.chipBorderRadius,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, color: color, size: 14),
//             const SizedBox(width: 4),
//           ],
//           Text(label, style: AppTextThemes.chipLabel.copyWith(color: color)),
//         ],
//       ),
//     );
//   }
// }

// class StreakChip extends StatelessWidget {
//   const StreakChip(this.count, {super.key, this.suffix = ''});

//   final int count;
//   final String suffix;

//   @override
//   Widget build(BuildContext context) {
//     return AppPill(
//       label: '$count$suffix',
//       icon: Icons.local_fire_department,
//       tone: AppPillTone.amber,
//     );
//   }
// }

// class AppStatCard extends StatelessWidget {
//   const AppStatCard({
//     super.key,
//     required this.value,
//     required this.label,
//     this.color = AppColors.textPrimary,
//   });

//   final String value;
//   final String label;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//       decoration: BoxDecoration(
//         color: AppColors.whiteWith(0.06),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: AppColors.whiteWith(0.07),
//           width: AppSpacings.cardOutlineWidth,
//         ),
//       ),
//       child: Column(
//         children: [
//           AppTexts.title2(
//             value,
//             context,
//             color: color,
//             fontWeight: FontWeight.w600,
//             center: true,
//           ),
//           const SizedBox(height: 2),
//           AppTexts.caption2(
//             label,
//             context,
//             color: AppColors.textTertiary,
//             center: true,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StepProgress extends StatelessWidget {
//   const StepProgress({super.key, required this.current, required this.total});

//   final int current;
//   final int total;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         for (var i = 0; i < total; i++)
//           Expanded(
//             child: Container(
//               height: 3,
//               margin: EdgeInsets.only(right: i == total - 1 ? 0 : 5),
//               decoration: BoxDecoration(
//                 color: i < current
//                     ? AppColors.primary
//                     : AppColors.whiteWith(0.1),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class PageDots extends StatelessWidget {
//   const PageDots({super.key, required this.current, required this.total});

//   final int current;
//   final int total;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         for (var i = 0; i < total; i++)
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 180),
//             width: i == current ? 13 : 5,
//             height: 5,
//             margin: const EdgeInsets.symmetric(horizontal: 3),
//             decoration: BoxDecoration(
//               color: i == current
//                   ? AppColors.primaryLight
//                   : AppColors.whiteWith(0.18),
//               borderRadius: BorderRadius.circular(3),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class UserAvatar extends StatelessWidget {
//   const UserAvatar({super.key, required this.name, this.size = 38});

//   final String name;
//   final double size;

//   @override
//   Widget build(BuildContext context) {
//     final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
//     final initials = parts
//         .take(2)
//         .map((p) => p.characters.first.toUpperCase())
//         .join();
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: AppColors.primaryWith(0.35),
//       ),
//       child: Center(
//         child: Text(
//           initials.isEmpty ? 'FA' : initials,
//           style: TextStyle(
//             color: AppColors.primaryLight,
//             fontSize: size * 0.32,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SettingsRow extends StatelessWidget {
//   const SettingsRow({
//     super.key,
//     required this.title,
//     this.subtitle,
//     this.trailing,
//     this.onTap,
//     this.danger = false,
//   });

//   final String title;
//   final String? subtitle;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//   final bool danger;

//   @override
//   Widget build(BuildContext context) {
//     final color = danger ? AppColors.danger : AppColors.textSecondary;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: color,
//                       fontSize: AppTextThemes.footnote,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   if (subtitle != null) ...[
//                     const SizedBox(height: 3),
//                     Text(
//                       subtitle!,
//                       style: const TextStyle(
//                         color: AppColors.textTertiary,
//                         fontSize: AppTextThemes.caption1,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             trailing ??
//                 Icon(
//                   danger ? Icons.logout : Icons.chevron_right,
//                   size: 18,
//                   color: danger ? AppColors.danger : AppColors.textTertiary,
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AppToggle extends StatelessWidget {
//   const AppToggle({super.key, required this.value});

//   final bool value;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 180),
//       width: 34,
//       height: 20,
//       padding: const EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         color: value ? AppColors.primary : AppColors.whiteWith(0.12),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       alignment: value ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         width: 16,
//         height: 16,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
