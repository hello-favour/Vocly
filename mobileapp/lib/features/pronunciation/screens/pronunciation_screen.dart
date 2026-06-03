import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/texts/app_texts.dart';
import '../../session/app_session_provider.dart';
import '../providers/pronunciation_provider.dart';
import '../widgets/audio_card.dart';

class PronunciationScreen extends ConsumerStatefulWidget {
  const PronunciationScreen({super.key});

  @override
  ConsumerState<PronunciationScreen> createState() =>
      _PronunciationScreenState();
}

class _PronunciationScreenState extends ConsumerState<PronunciationScreen> {
  bool recording = false;
  String word = 'Articulate';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pronunciationScoreProvider);

    return AppScreen(
      children: [
        Row(
          children: [
            AppTexts.title3('Pronunciation', context),
            const Spacer(),
            AppTexts.caption1(
              '1 / 3 free',
              context,
              color: AppColors.textTertiary,
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        Center(child: AppPill(label: 'Today’s word')),
        const SizedBox(height: AppSpacings.iconGap),
        AppTexts.title2(word, context, center: true),
        const SizedBox(height: AppSpacings.elementSpacingTiny),
        AppTexts.body(
          '/ɑːrˈtɪk.jʊ.lɪt/',
          context,
          color: AppColors.primaryLight,
          center: true,
        ),
        const SizedBox(height: AppSpacings.sectionSpacing),
        Row(
          children: const [
            Expanded(
              child: AudioCard(
                icon: Icons.volume_up_outlined,
                label: 'Hear it',
                active: true,
              ),
            ),
            SizedBox(width: AppSpacings.iconGap),
            Expanded(
              child: AudioCard(icon: Icons.play_arrow, label: 'Your attempt'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.pageSpacing),
        Row(
          children: [
            Expanded(child: Divider(color: AppColors.whiteWith(0.1))),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacings.iconGap,
              ),
              child: AppTexts.caption1(
                'tap to start',
                context,
                color: AppColors.textTertiary,
              ),
            ),
            Expanded(child: Divider(color: AppColors.whiteWith(0.1))),
          ],
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: recording
                    ? AppColors.danger
                    : AppColors.primary,
              ),
              iconSize: 44,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      setState(() => recording = !recording);
                      if (recording) return;
                      final result = await ref
                          .read(pronunciationScoreProvider.notifier)
                          .score(word);
                      ref.read(appSessionProvider.notifier).markActivity();
                      if (context.mounted) {
                        context.push(
                          AppRoutes.pronunciationResult,
                          extra: {
                            'word': result.word,
                            'score': result.scoreOverall,
                          },
                        );
                      }
                    },
              icon: Icon(recording ? Icons.stop : Icons.mic),
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.elementSpacing),
        AppTexts.caption1(
          recording ? 'Recording... tap again to score' : 'Hold to record',
          context,
          color: AppColors.textTertiary,
          center: true,
        ),
        const SizedBox(height: AppSpacings.sectionSpacing),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts.caption1(
                'Last attempt — 2 days ago',
                context,
                color: AppColors.textTertiary,
              ),
              const SizedBox(height: AppSpacings.iconGap),
              Row(
                children: [
                  AppTexts.body('Overall', context),
                  const Spacer(),
                  AppTexts.headline(
                    '82',
                    context,
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacings.elementSpacing),
              const LinearProgressIndicator(
                value: 0.82,
                color: AppColors.success,
                backgroundColor: AppColors.border,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
