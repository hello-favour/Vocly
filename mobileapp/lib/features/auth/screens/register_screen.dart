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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final nameController = TextEditingController(text: 'Paul Jeremiah');
  final emailController = TextEditingController(text: 'paul@example.com');
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
          AppTexts.title3('Create account', context),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.body(
            'Start your free journey today',
            context,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppTextField(controller: nameController, label: 'Full name'),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTextField(controller: emailController, label: 'Email'),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            hint: '••••••••••',
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppButton(
            label: 'Create account',
            onPressed: () async {
              await ref
                  .read(appSessionProvider.notifier)
                  .signUp(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );
              if (context.mounted) context.go(AppRoutes.onboarding);
            },
          ),
          const AuthDivider(),
          AppCard(
            padding: const EdgeInsets.all(AppSpacings.cardPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.g_mobiledata, color: AppColors.textSecondary),
                const SizedBox(width: AppSpacings.elementSpacing),
                AppTexts.body('Continue with Google', context),
              ],
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTexts.body(
                'Already have an account?',
                context,
                color: AppColors.textTertiary,
              ),
              GestureDetector(
                onTap: () => context.go(AppRoutes.login),
                child: AppTexts.button(
                  'Sign in',
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
