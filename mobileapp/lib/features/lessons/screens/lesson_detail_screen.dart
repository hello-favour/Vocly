import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/exceptions/app_exceptions.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_stat_card.dart';
import 'package:mobileapp/core/widgets/page_dots.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/lessons/models/upgrade_card.dart';
import 'package:mobileapp/features/lessons/providers/lessons_provider.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class LessonDetailScreen extends ConsumerStatefulWidget {
  const LessonDetailScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  ConsumerState<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends ConsumerState<LessonDetailScreen> {
  final controller = PageController();
  int page = 0;
  bool complete = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = ref.watch(upgradeCardByIdProvider(widget.lessonId));
    if (card == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: AppTexts.body('Upgrade not found', context)),
      );
    }

    if (complete) return _CompletionView(card: card);

    final pages = [
      _UpgradePage(card: card),
      _ContextPage(card: card),
      _UsagePage(card: card),
      _PracticePage(card: card),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[page]),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacings.screenPadding),
            child: AppTexts.caption1(
              '${page + 1} / ${pages.length}',
              context,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacings.elementSpacing),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) => setState(() => page = value),
                children: pages,
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            PageDots(current: page, total: pages.length),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            Row(
              children: [
                if (page > 0) ...[
                  Expanded(
                    child: AppButton(
                      label: 'Back',
                      variant: AppButtonVariant.secondary,
                      onPressed: () => controller.previousPage(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacings.iconGap),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    label: page == pages.length - 1
                        ? 'Complete lesson'
                        : 'Next',
                    onPressed: () async {
                      if (page < pages.length - 1) {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                        );
                        return;
                      }
                      try {
                        await ref
                            .read(upgradeCardsRepositoryProvider)
                            .completeCard(card.id);
                      } on FreeLimitReachedException {
                        if (context.mounted) {
                          context.push(AppRoutes.paywall, extra: 'upgrades');
                        }
                        return;
                      }
                      ref
                          .read(appSessionProvider.notifier)
                          .applyServerActivity(coins: 10);
                      if (mounted) setState(() => complete = true);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UpgradePage extends StatelessWidget {
  const _UpgradePage({required this.card});

  final UpgradeCard card;

  @override
  Widget build(BuildContext context) {
    return _PageCard(
      label: card.upgradeLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SmallLabel('BASIC'),
          AppTexts.title2(
            card.basicPhrase,
            context,
            color: AppColors.textTertiary,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSpacings.elementSpacingLarge,
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              color: AppColors.accent,
              size: 32,
            ),
          ),
          const _SmallLabel('PRO'),
          AppTexts.title1(card.proPhrase, context, color: AppColors.primary),
          const Spacer(),
          _AudioButton(enabled: card.audioProUrl != null),
        ],
      ),
    );
  }
}

class _ContextPage extends StatelessWidget {
  const _ContextPage({required this.card});

  final UpgradeCard card;

  @override
  Widget build(BuildContext context) {
    return _PageCard(
      label: 'In context',
      child: ListView(
        children: [
          AppTexts.title2('Hear how it fits naturally', context),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          _DialogueBlock(dialogue: card.contextDialogue1),
          const SizedBox(height: AppSpacings.elementSpacing),
          _DialogueBlock(dialogue: card.contextDialogue2),
        ],
      ),
    );
  }
}

class _UsagePage extends StatelessWidget {
  const _UsagePage({required this.card});

  final UpgradeCard card;

  @override
  Widget build(BuildContext context) {
    return _PageCard(
      label: 'Know when to use it',
      child: ListView(
        children: [
          _UsageBlock(
            icon: Icons.check_circle_outline,
            title: 'Use it when',
            body: card.whenToUse,
            color: AppColors.success,
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          _UsageBlock(
            icon: Icons.block,
            title: 'Avoid it when',
            body: card.whenNotToUse,
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          _UsageBlock(
            icon: Icons.tune,
            title: 'Register',
            body: card.register,
            color: AppColors.info,
          ),
        ],
      ),
    );
  }
}

class _PracticePage extends StatelessWidget {
  const _PracticePage({required this.card});

  final UpgradeCard card;

  @override
  Widget build(BuildContext context) {
    return _PageCard(
      label: 'Your turn',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.title2('Say this out loud', context),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppCard(
            color: AppColors.primaryWith(0.08),
            child: AppTexts.title2(
              '“${card.proPhrase}”',
              context,
              color: AppColors.primary,
              center: true,
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.body(
            'Say it once slowly, then repeat it at a natural pace.',
            context,
            color: AppColors.textSecondary,
          ),
          const Spacer(),
          AppButton(
            label: 'Practise this phrase',
            variant: AppButtonVariant.secondary,
            onPressed: () => context.go(AppRoutes.pronunciationTab),
          ),
        ],
      ),
    );
  }
}

class _CompletionView extends ConsumerWidget {
  const _CompletionView({required this.card});

  final UpgradeCard card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson complete')),
      body: AppScreen(
        children: [
          const SizedBox(height: AppSpacings.pageSpacing),
          const Icon(Icons.auto_awesome, color: AppColors.accent, size: 72),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.title2('That sounds more natural.', context, center: true),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.body(
            'You upgraded “${card.basicPhrase}” to “${card.proPhrase}”',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          Row(
            children: [
              const Expanded(
                child: AppStatCard(
                  value: '1',
                  label: 'Phrase upgraded',
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: AppSpacings.elementSpacing),
              Expanded(
                child: AppStatCard(
                  value:
                      '${session.streakCount == 0 ? 1 : session.streakCount}',
                  label: 'Day streak',
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacings.sectionSpacing),
          AppButton(
            label: 'Continue to next lesson',
            onPressed: () {
              ref.invalidate(todaysUpgradeCardsProvider);
              context.go(AppRoutes.lessonsTab);
            },
          ),
        ],
      ),
    );
  }
}

class _PageCard extends StatelessWidget {
  const _PageCard({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.primaryWith(0.06),
      padding: const EdgeInsets.all(AppSpacings.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppPill(label: label),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _DialogueBlock extends StatelessWidget {
  const _DialogueBlock({required this.dialogue});

  final UpgradeDialogue dialogue;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.caption1(
            dialogue.label.toUpperCase(),
            context,
            color: AppColors.primaryLight,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          for (final line in dialogue.lines) ...[
            AppTexts.body(line, context, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacings.elementSpacingSmall),
          ],
        ],
      ),
    );
  }
}

class _UsageBlock extends StatelessWidget {
  const _UsageBlock({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacings.elementSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.caption1(
                  title,
                  context,
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: AppSpacings.elementSpacingSmall),
                AppTexts.body(body, context, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallLabel extends StatelessWidget {
  const _SmallLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.elementSpacingSmall),
      child: AppTexts.caption2(
        text,
        context,
        color: AppColors.primaryLight,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AudioButton extends StatelessWidget {
  const _AudioButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.volume_up_outlined,
          color: enabled ? AppColors.primary : AppColors.textTertiary,
        ),
        const SizedBox(width: AppSpacings.elementSpacingSmall),
        AppTexts.caption1(
          enabled ? 'Hear the natural pronunciation' : 'Audio coming soon',
          context,
          color: AppColors.textTertiary,
        ),
      ],
    );
  }
}

const _pageTitles = ['The upgrade', 'In context', 'Usage guide', 'Practice'];
