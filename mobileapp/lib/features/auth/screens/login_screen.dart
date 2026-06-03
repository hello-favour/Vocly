import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_text_field.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/auth/widgets/auth_divider.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController(text: 'paul@example.com');
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScreen(
        safeArea: true,
        padding: const EdgeInsets.all(AppSpacings.screenPadding),
        children: [
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppTexts.title3('Welcome back', context),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.body(
            'Sign in to continue your streak',
            context,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppTextField(
            controller: emailController,
            label: 'Email',
            hint: 'paul@example.com',
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            hint: '••••••••••',
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: AppTexts.button(
                'Forgot password?',
                context,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppButton(
            label: 'Sign in',
            onPressed: () async {
              await ref
                  .read(appSessionProvider.notifier)
                  .signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
              if (context.mounted) context.go(AppRoutes.lessonsTab);
            },
          ),
          const AuthDivider(),
          GestureDetector(
            onTap: () =>
                ref.read(appSessionProvider.notifier).signInWithGoogle(),
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacings.cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.g_mobiledata,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacings.elementSpacing),
                  AppTexts.body('Continue with Google', context),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTexts.body(
                'Don’t have an account?',
                context,
                color: AppColors.textTertiary,
              ),
              TextButton(
                onPressed: () => context.go(AppRoutes.register),
                child: AppTexts.button(
                  'Sign up',
                  context,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
