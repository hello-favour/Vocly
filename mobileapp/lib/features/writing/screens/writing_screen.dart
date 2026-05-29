import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../session/app_session_provider.dart';
import '../providers/writing_provider.dart';

class WritingScreen extends ConsumerStatefulWidget {
  const WritingScreen({super.key});

  @override
  ConsumerState<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends ConsumerState<WritingScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkState = ref.watch(writingCheckProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          'AI writing checker',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Paste an email, message, or cover-letter sentence.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            children: [
              AppTextField(
                controller: controller,
                label: 'Your sentence',
                hint: 'I want to ask if you have seen my last mail',
                minLines: 5,
                maxLines: 8,
                maxLength: 500,
              ),
              const SizedBox(height: 12),
              AppButton(
                label: checkState.isLoading
                    ? 'Checking...'
                    : 'Check my writing',
                icon: Icons.auto_fix_high,
                onPressed: checkState.isLoading
                    ? null
                    : () async {
                        final text = controller.text.trim();
                        if (text.length < 5) {
                          AppSnackbar.show(
                            context,
                            'Enter at least 5 characters.',
                          );
                          return;
                        }
                        final result = await ref
                            .read(writingCheckProvider.notifier)
                            .check(text);
                        ref.read(appSessionProvider.notifier).markActivity();
                        if (context.mounted) {
                          context.push('/writing/result', extra: result);
                        }
                      },
              ),
              const SizedBox(height: 8),
              const Text('0 of 5 free checks used today'),
            ],
          ),
        ),
      ],
    );
  }
}
