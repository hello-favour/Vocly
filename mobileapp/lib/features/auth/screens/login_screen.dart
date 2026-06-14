import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_snackbar.dart';
import 'package:mobileapp/core/widgets/app_text_field.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/auth/widgets/auth_divider.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';
import 'package:mobileapp/utils/validations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool submitting = false;

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
          Form(
            key: formKey,
            child: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacings.sectionSpacing),
                  AppTexts.title3('Welcome back', context),
                  const SizedBox(height: AppSpacings.elementSpacingTiny),
                  AppTexts.body(
                    'Sign in to continue your speaking streak.',
                    context,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: AppSpacings.sectionSpacing),
                  AppTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'you@email.com',
                    validator: AppValidations.validatedEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    enabled: !submitting,
                  ),
                  const SizedBox(height: AppSpacings.elementSpacing),
                  AppTextField(
                    controller: passwordController,
                    label: 'Password',
                    validator: AppValidations.validateSignInPassword,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    enabled: !submitting,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: submitting
                          ? null
                          : () => context.push(AppRoutes.forgotPassword),
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingSmall),
                  AppButton(
                    label: submitting ? 'Signing in...' : 'Sign in',
                    onPressed: submitting ? null : _submit,
                  ),
                  const AuthDivider(),
                  InkWell(
                    onTap: submitting ? null : _signInWithGoogle,
                    borderRadius: AppSpacings.cardBorderRadius,
                    child: AppCard(
                      padding: const EdgeInsets.all(AppSpacings.cardPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/google-icon.svg',
                            width: 18,
                            fit: BoxFit.scaleDown,
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
                        onPressed: submitting
                            ? null
                            : () => context.go(AppRoutes.register),
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
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
      await ref
          .read(appSessionProvider.notifier)
          .signIn(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
      if (mounted) context.go(AppRoutes.lessonsTab);
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

  Future<void> _signInWithGoogle() async {
    setState(() => submitting = true);
    try {
      await ref.read(appSessionProvider.notifier).signInWithGoogle();
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
