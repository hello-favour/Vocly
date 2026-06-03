import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_strings.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/paywall/providers/subscription_provider.dart';
import 'package:mobileapp/features/paywall/widgets/paywall_feature_row.dart';
import 'package:mobileapp/features/paywall/widgets/paywall_plan_card.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key, this.trigger});

  final String? trigger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sub = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      body: AppScreen(
        safeArea: true,
        background: AppColors.backgroundDeep,
        padding: const EdgeInsets.all(AppSpacings.elementSpacing),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              tooltip: 'Close',
              icon: const Icon(Icons.close, color: AppColors.textTertiary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Center(
            child: Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryWith(0.18),
                border: Border.all(color: AppColors.primaryLightWith(0.3)),
              ),
              child: const Icon(
                Icons.workspace_premium,
                color: AppColors.primaryLight,
                size: 48,
              ),
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppTexts.title3('Unlock Pro', context, center: true),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.body(
            'Speak with confidence, every day',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          if (trigger != null) ...[
            const SizedBox(height: AppSpacings.elementSpacing),
            Center(child: AppPill(label: 'Limit: $trigger')),
          ],
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          const PaywallFeatureRow('Unlimited lessons & AI writing feedback'),
          const PaywallFeatureRow('Full pronunciation scores & history'),
          const PaywallFeatureRow('Streak freeze protection'),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          const PaywallPlanCard(
            title: 'Yearly',
            subtitle: 'Save 33% · \$3.33/mo',
            price: '\$39.99/yr',
            badge: 'Best value',
            selected: true,
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          const PaywallPlanCard(
            title: 'Monthly',
            subtitle: 'Billed monthly',
            price: '\$4.99/mo',
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          const PaywallPlanCard(
            title: 'Lifetime',
            subtitle: 'Pay once forever',
            price: '\$59.99',
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          AppButton(
            label: 'Get Pro — start today',
            onPressed: () {
              ref.read(appSessionProvider.notifier).setPro(true);
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppButton(
            label: sub.isLoading ? 'Restoring...' : 'Restore purchases',
            variant: AppButtonVariant.ghost,
            onPressed: sub.isLoading
                ? null
                : () => ref
                      .read(subscriptionProvider.notifier)
                      .restorePurchases(),
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.caption1(
            AppStrings.tagline,
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
        ],
      ),
    );
  }
}
