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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool submitting = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppScreen(
        padding: const EdgeInsets.all(AppSpacings.screenPadding),
        children: [
          const Icon(Icons.password, color: AppColors.primary, size: 64),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.title2('Create a new password', context),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.body(
            'Use at least 8 characters with uppercase, lowercase, and a number.',
            context,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          Form(
            key: formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: passwordController,
                  label: 'New password',
                  validator: AppValidations.validatePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.newPassword],
                  enabled: !submitting,
                ),
                const SizedBox(height: AppSpacings.elementSpacing),
                AppTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm new password',
                  validator: (value) => AppValidations.validateConfirmPassword(
                    value,
                    password: passwordController.text,
                  ),
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  enabled: !submitting,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: AppSpacings.elementSpacingLarge),
                AppButton(
                  label: submitting ? 'Updating...' : 'Update password',
                  onPressed: submitting ? null : _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (formKey.currentState?.validate() != true) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => submitting = true);
    try {
      final repository = AuthRepository();
      await repository.updatePassword(passwordController.text);
      await repository.signOut();
      if (!mounted) return;
      AppSnackbar.showSnackBar(
        context,
        message: 'Password updated. Sign in with your new password.',
        type: SnackBarType.success,
      );
      context.go(AppRoutes.login);
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
