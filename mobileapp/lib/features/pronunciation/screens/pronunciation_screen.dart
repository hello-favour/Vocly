import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../session/app_session_provider.dart';
import '../providers/pronunciation_provider.dart';

class PronunciationScreen extends ConsumerStatefulWidget {
  const PronunciationScreen({super.key});

  @override
  ConsumerState<PronunciationScreen> createState() =>
      _PronunciationScreenState();
}

class _PronunciationScreenState extends ConsumerState<PronunciationScreen> {
  final wordController = TextEditingController(text: 'concise');
  bool recording = false;

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pronunciationScoreProvider);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          'Pronunciation practice',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Hear the word, record yourself, and get a score.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            children: [
              AppTextField(
                controller: wordController,
                label: 'Word to practice',
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Hear it',
                icon: Icons.volume_up,
                variant: AppButtonVariant.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              IconButton.filled(
                iconSize: 48,
                onPressed: state.isLoading
                    ? null
                    : () async {
                        setState(() => recording = !recording);
                        if (recording) return;
                        final result = await ref
                            .read(pronunciationScoreProvider.notifier)
                            .score(wordController.text);
                        ref.read(appSessionProvider.notifier).markActivity();
                        if (context.mounted) {
                          context.push(
                            '/pronunciation/result',
                            extra: {
                              'word': result.word,
                              'score': result.scoreOverall,
                            },
                          );
                        }
                      },
                icon: Icon(recording ? Icons.stop : Icons.mic),
              ),
              const SizedBox(height: 8),
              Text(
                recording
                    ? 'Recording... tap again to score'
                    : 'Tap the mic to start',
              ),
              const SizedBox(height: 8),
              const Text('0 of 3 free attempts used today'),
            ],
          ),
        ),
      ],
    );
  }
}
