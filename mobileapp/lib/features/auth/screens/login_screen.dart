import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../session/app_session_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          children: [
            const SizedBox(height: 32),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.tagline,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            AppCard(
              child: Column(
                children: [
                  AppTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'you@example.com',
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    label: 'Continue',
                    icon: Icons.arrow_forward,
                    onPressed: () async {
                      await ref.read(appSessionProvider.notifier).signIn();
                      if (context.mounted) context.go('/onboarding');
                    },
                  ),
                  const SizedBox(height: 8),
                  AppButton(
                    label: 'Create an account',
                    variant: AppButtonVariant.ghost,
                    onPressed: () => context.go('/auth/register'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
