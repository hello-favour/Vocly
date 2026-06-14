import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/exceptions/app_exceptions.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_loader.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/lessons/providers/lessons_provider.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class LessonsScreen extends ConsumerWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(todaysUpgradeCardsProvider);
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

    return cards.when(
      loading: () => const AppLoader(),
      error: (error, stackTrace) {
        if (error is FreeLimitReachedException) {
          return AppScreen(
            children: [
              const SizedBox(height: AppSpacings.pageSpacing),
              AppTexts.title2(
                'You completed today’s free upgrades.',
                context,
                center: true,
              ),
              const SizedBox(height: AppSpacings.elementSpacing),
              AppTexts.body(
                'Come back tomorrow or unlock unlimited upgrades with Pro.',
                context,
                color: AppColors.textTertiary,
                center: true,
              ),
              const SizedBox(height: AppSpacings.elementSpacingLarge),
              AppButton(
                label: 'See Vocly Pro',
                onPressed: () =>
                    context.push(AppRoutes.paywall, extra: 'upgrades'),
              ),
            ],
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacings.screenPadding),
            child: AppTexts.body(
              'Could not load today’s upgrades. Please try again.',
              context,
              center: true,
            ),
          ),
        );
      },
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: AppTexts.body(
              'No upgrades are available for today yet.',
              context,
            ),
          );
        }

        final card = items.first;
        return AppScreen(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts.title2('Today’s speaking lesson', context),
                      const SizedBox(height: AppSpacings.elementSpacingTiny),
                      AppTexts.caption1(
                        'Lesson 1 of 3 · Keep your streak alive',
                        context,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacings.elementSpacingSmall),
                AppPill(label: card.domainLabel),
              ],
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            AppCard(
              color: AppColors.primaryWith(0.08),
              padding: const EdgeInsets.all(AppSpacings.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.caption1(
                    card.upgradeLabel.toUpperCase(),
                    context,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingLarge),
                  _PhrasePreview(
                    label: 'BASIC',
                    phrase: card.basicPhrase,
                    color: AppColors.textTertiary,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacings.elementSpacing,
                    ),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: AppColors.accent,
                    ),
                  ),
                  _PhrasePreview(
                    label: 'SAY THIS',
                    phrase: card.proPhrase,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: AppSpacings.elementSpacingLarge),
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 18,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: AppSpacings.elementSpacingSmall),
                      AppTexts.caption1(
                        'About 2 minutes',
                        context,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacing),
            AppCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacings.elementSpacing,
                vertical: AppSpacings.elementSpacingSmall,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_outlined,
                    size: 20,
                    color: AppColors.primaryLight,
                  ),
                  const SizedBox(width: AppSpacings.elementSpacingSmall),
                  Expanded(
                    child: AppTexts.body(
                      session.isPro
                          ? 'Unlimited upgrades with Pro'
                          : '3 upgrades available today',
                      context,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  AppPill(
                    label: '${_shortRegister(card.register)} tone',
                    tone: AppPillTone.green,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacings.elementSpacingLarge),
            AppButton(
              label: 'Start today’s lesson',
              onPressed: () => context.push(AppRoutes.upgrade(card.id)),
            ),
          ],
        );
      },
    );
  }
}

String _shortRegister(String register) {
  final normalized = register.trim().toLowerCase();
  if (normalized.contains('formal')) return 'Formal';
  if (normalized.contains('casual')) return 'Casual';
  return 'Neutral';
}

class _PhrasePreview extends StatelessWidget {
  const _PhrasePreview({
    required this.label,
    required this.phrase,
    required this.color,
  });

  final String label;
  final String phrase;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts.caption2(
          label,
          context,
          color: color,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: AppSpacings.elementSpacingSmall),
        AppTexts.title2(phrase, context, color: color),
      ],
    );
  }
}
