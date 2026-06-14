import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/exceptions/app_exceptions.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_snackbar.dart';
import 'package:mobileapp/core/widgets/app_text_field.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';
import 'package:mobileapp/features/writing/providers/writing_provider.dart';
import 'package:mobileapp/features/writing/widgets/feedback_option.dart';

class WritingScreen extends ConsumerStatefulWidget {
  const WritingScreen({super.key});

  @override
  ConsumerState<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends ConsumerState<WritingScreen> {
  final controller = TextEditingController(
    text:
        'I has been working here since three years and never get any complaint from my manager about my performance.',
  );
  final selectedFeedback = <String>{'Grammar', 'Clarity'};

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkState = ref.watch(writingCheckProvider);

    return AppScreen(
      children: [
        Row(
          children: [
            AppTexts.headline(
              'AI Writing Upgrade',
              context,
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            AppTexts.caption1(
              '2 / 5 free',
              context,
              color: AppColors.textTertiary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        AppTextField(
          controller: controller,
          label: 'Your text',
          minLines: 6,
          maxLines: 9,
          maxLength: 500,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            tooltip: 'Clear',
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.textTertiary,
            ),
            onPressed: controller.clear,
          ),
        ),
        const SectionLabel('What should Vocly improve?'),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: AppSpacings.elementSpacing,
          crossAxisSpacing: AppSpacings.elementSpacing,
          childAspectRatio: 3.3,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (final item in ['Grammar', 'Clarity', 'Word choice', 'Tone'])
              FeedbackOption(
                label: item,
                selected: selectedFeedback.contains(item),
                onTap: () {
                  setState(() {
                    if (selectedFeedback.contains(item)) {
                      selectedFeedback.remove(item);
                    } else {
                      selectedFeedback.add(item);
                    }
                  });
                },
              ),
          ],
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        AppButton(
          label: checkState.isLoading ? 'Upgrading...' : 'Upgrade my writing',
          onPressed: checkState.isLoading
              ? null
              : () async {
                  final text = controller.text.trim();
                  if (text.length < 5) {
                    AppSnackbar.showSnackBar(
                      context,
                      message: 'Enter at least 5 characters.',
                      type: SnackBarType.warning,
                    );
                    return;
                  }
                  try {
                    final result = await ref
                        .read(writingCheckProvider.notifier)
                        .check(text);
                    ref.read(appSessionProvider.notifier).markActivity();
                    if (context.mounted) {
                      context.push(AppRoutes.writingResult, extra: result);
                    }
                  } on FreeLimitReachedException {
                    if (context.mounted) {
                      context.push(AppRoutes.paywall, extra: 'writing');
                    }
                  }
                },
        ),
        const SizedBox(height: AppSpacings.elementSpacing),
        AppButton(
          label: 'View writing history',
          variant: AppButtonVariant.ghost,
          onPressed: () => context.push(AppRoutes.writingHistory),
        ),
      ],
    );
  }
}
