import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/constants/app_strings.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreen(
        safeArea: true,
        padding: const EdgeInsets.all(AppSpacings.screenPadding),
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primaryWith(0.25),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.primaryLightWith(0.3)),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: AppColors.primaryLight,
                size: 46,
              ),
            ),
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppTexts.title2(AppStrings.appName, context, center: true),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTexts.body(
            'Speak English with clarity and confidence',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          const SizedBox(height: AppSpacings.pageSpacing),
          AppButton(
            label: 'Get started',
            onPressed: () => context.go(AppRoutes.register),
          ),
          const SizedBox(height: AppSpacings.iconGap),
          AppButton(
            label: 'I already have an account',
            variant: AppButtonVariant.secondary,
            onPressed: () => context.go(AppRoutes.login),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.caption1(
            'By continuing you agree to our\nTerms & Privacy Policy',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
        ],
      ),
    );
  }
}
