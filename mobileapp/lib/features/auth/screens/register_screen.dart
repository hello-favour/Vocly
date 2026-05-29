import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../session/app_session_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        children: [
          AppCard(
            child: Column(
              children: [
                AppTextField(controller: nameController, label: 'Name'),
                const SizedBox(height: 12),
                AppTextField(controller: emailController, label: 'Email'),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Start onboarding',
                  icon: Icons.person_add_alt,
                  onPressed: () async {
                    await ref
                        .read(appSessionProvider.notifier)
                        .signIn(name: nameController.text.trim());
                    if (context.mounted) context.go('/onboarding');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
