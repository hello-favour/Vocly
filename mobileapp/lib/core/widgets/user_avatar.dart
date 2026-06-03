import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.name, this.size = 38});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final initials = parts
        .take(2)
        .map((p) => p.characters.first.toUpperCase())
        .join();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryWith(0.35),
      ),
      child: Center(
        child: Text(
          initials.isEmpty ? 'FA' : initials,
          style: TextStyle(
            color: AppColors.primaryLight,
            fontSize: size * 0.32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
