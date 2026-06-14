import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/exceptions/app_exceptions.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_snackbar.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/lessons/providers/lessons_provider.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

import '../providers/pronunciation_provider.dart';

class PronunciationScreen extends ConsumerStatefulWidget {
  const PronunciationScreen({super.key});

  @override
  ConsumerState<PronunciationScreen> createState() =>
      _PronunciationScreenState();
}

class _PronunciationScreenState extends ConsumerState<PronunciationScreen> {
  bool recording = false;

  @override
  Widget build(BuildContext context) {
    final scoreState = ref.watch(pronunciationScoreProvider);
    final cards = ref.watch(todaysUpgradeCardsProvider).valueOrNull;
    final phrase =
        cards?.firstOrNull?.proPhrase ?? 'Let’s get the ball rolling.';

    return AppScreen(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTexts.title2(
                'Practise speaking',
                context,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacings.elementSpacingSmall),
            const AppPill(label: '3 free today'),
          ],
        ),
        const SizedBox(height: AppSpacings.sectionSpacing),
        AppCard(
          color: AppColors.primaryWith(0.07),
          child: Column(
            children: [
              AppTexts.caption1(
                'TODAY’S PRO PHRASE',
                context,
                color: AppColors.primaryLight,
                fontWeight: FontWeight.w700,
                center: true,
              ),
              const SizedBox(height: AppSpacings.elementSpacingLarge),
              AppTexts.title1(
                '“$phrase”',
                context,
                color: AppColors.primary,
                center: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacings.sectionSpacing),
        AppTexts.body(
          'Listen, then say the phrase naturally.',
          context,
          color: AppColors.textSecondary,
          center: true,
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        Center(
          child: SizedBox(
            width: 112,
            height: 112,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: recording
                    ? AppColors.danger
                    : AppColors.primary,
              ),
              iconSize: 48,
              onPressed: scoreState.isLoading
                  ? null
                  : () => _toggleRecording(phrase),
              icon: Icon(recording ? Icons.stop : Icons.mic),
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.elementSpacing),
        AppTexts.caption1(
          scoreState.isLoading
              ? 'Checking your pronunciation...'
              : recording
              ? 'Recording... tap to finish'
              : 'Tap to speak',
          context,
          color: AppColors.textTertiary,
          center: true,
        ),
      ],
    );
  }

  Future<void> _toggleRecording(String phrase) async {
    try {
      if (!recording) {
        await ref.read(pronunciationScoreProvider.notifier).startRecording();
        if (mounted) setState(() => recording = true);
        return;
      }

      setState(() => recording = false);
      final result = await ref
          .read(pronunciationScoreProvider.notifier)
          .stopAndScore(phrase);
      ref.read(appSessionProvider.notifier).markActivity();
      if (mounted) {
        context.push(
          AppRoutes.pronunciationResult,
          extra: {'word': result.word, 'score': result.scoreOverall},
        );
      }
    } on FreeLimitReachedException {
      if (mounted) {
        setState(() => recording = false);
        context.push(AppRoutes.paywall, extra: 'pronunciation');
      }
    } catch (error) {
      if (mounted) {
        setState(() => recording = false);
        AppSnackbar.showSnackBar(
          context,
          message: error.toString(),
          type: SnackBarType.error,
        );
      }
    }
  }
}
