import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_snackbar.dart';
import 'package:mobileapp/core/widgets/app_text_field.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/auth/data/auth_repository.dart';
import 'package:mobileapp/utils/validations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool submitting = false;
  bool sent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppScreen(
        padding: const EdgeInsets.all(AppSpacings.screenPadding),
        children: [
          const SizedBox(height: AppSpacings.elementSpacing),
          Icon(
            sent ? Icons.mark_email_read_outlined : Icons.lock_reset,
            color: AppColors.primary,
            size: 64,
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.title2(
            sent ? 'Check your email' : 'Reset your password',
            context,
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.body(
            sent
                ? 'We sent a secure reset link to ${emailController.text.trim()}.'
                : 'Enter the email used for your Vocly account.',
            context,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          if (!sent)
            Form(
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'you@email.com',
                    validator: AppValidations.validatedEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.email],
                    enabled: !submitting,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingLarge),
                  AppButton(
                    label: submitting ? 'Sending...' : 'Send reset link',
                    onPressed: submitting ? null : _submit,
                  ),
                ],
              ),
            )
          else ...[
            AppButton(
              label: 'Back to sign in',
              onPressed: () => context.go(AppRoutes.login),
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            AppButton(
              label: 'Send again',
              variant: AppButtonVariant.ghost,
              onPressed: () => setState(() => sent = false),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (formKey.currentState?.validate() != true) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => submitting = true);
    try {
      await AuthRepository().sendPasswordResetEmail(
        emailController.text.trim(),
      );
      if (mounted) setState(() => sent = true);
    } catch (error) {
      if (mounted) {
        AppSnackbar.showSnackBar(
          context,
          message: error.toString(),
          type: SnackBarType.error,
        );
      }
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}
