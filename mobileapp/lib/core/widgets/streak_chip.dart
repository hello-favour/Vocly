import 'package:flutter/material.dart';

import 'app_pill.dart';

class StreakChip extends StatelessWidget {
  const StreakChip(this.count, {super.key, this.suffix = ''});

  final int count;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return AppPill(
      label: '$count$suffix',
      icon: Icons.local_fire_department,
      tone: AppPillTone.amber,
    );
  }
}
