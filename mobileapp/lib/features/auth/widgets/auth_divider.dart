import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/texts/app_texts.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.compactControlPaddingVertical,
      ),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.whiteWith(0.1))),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.elementSpacingSmall,
            ),
            child: AppTexts.caption2(
              'or',
              context,
              color: AppColors.textTertiary,
            ),
          ),
          Expanded(child: Divider(color: AppColors.whiteWith(0.1))),
        ],
      ),
    );
  }
}
