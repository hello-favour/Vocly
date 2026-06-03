import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/profile/widgets/coin_row.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class CoinsScreen extends ConsumerWidget {
  const CoinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

    return Scaffold(
      appBar: AppBar(title: const Text('Coins & rewards')),
      body: AppScreen(
        children: [
          AppCard(
            child: Row(
              children: [
                const Icon(Icons.paid, color: AppColors.warning, size: 42),
                const SizedBox(width: AppSpacings.elementSpacing),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.title3(
                      '${session.coins == 0 ? 120 : session.coins}',
                      context,
                    ),
                    AppTexts.caption1(
                      'Total coins',
                      context,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
                const Spacer(),
                const AppPill(label: 'Earn more', tone: AppPillTone.amber),
              ],
            ),
          ),
          const SectionLabel('How to earn coins'),
          const AppCard(
            child: Column(
              children: [
                CoinRow(label: 'Complete daily lesson', value: '+10'),
                CoinRow(label: 'AI writing check', value: '+5'),
                CoinRow(label: 'Pronunciation attempt', value: '+5'),
                CoinRow(label: '7-day streak milestone', value: '+50'),
              ],
            ),
          ),
          const SectionLabel('Spend coins'),
          AppCard(
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: AppColors.primaryLight,
                ),
                const SizedBox(width: AppSpacings.iconGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts.body('Streak freeze', context),
                      const SizedBox(height: AppSpacings.elementSpacingTiny),
                      AppTexts.caption1(
                        'Protect your streak for 1 day',
                        context,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 128,
                  child: AppButton(label: '50 coins', onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
