import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../session/app_session_provider.dart';
import '../providers/subscription_provider.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key, this.trigger});

  final String? trigger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sub = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Go Pro')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Unlimited daily lessons, writing checks, pronunciation scoring, and progress history.',
          ),
          if (trigger != null) ...[
            const SizedBox(height: 8),
            Text('Triggered by: $trigger'),
          ],
          const SizedBox(height: 16),
          const AppCard(
            child: Text(
              'Unlimited AI writing feedback\nFull pronunciation reports\nHistory and streak tools',
            ),
          ),
          const SizedBox(height: 12),
          const _PlanCard(title: 'Monthly', price: r'$4.99/mo'),
          const SizedBox(height: 8),
          const _PlanCard(
            title: 'Yearly',
            price: r'$39.99/yr',
            badge: 'Best value',
          ),
          const SizedBox(height: 8),
          const _PlanCard(title: 'Lifetime', price: r'$59.99'),
          const SizedBox(height: 16),
          AppButton(
            label: 'Get Pro',
            icon: Icons.workspace_premium,
            onPressed: () {
              ref.read(appSessionProvider.notifier).setPro(true);
              Navigator.of(context).pop();
            },
          ),
          AppButton(
            label: sub.isLoading ? 'Restoring...' : 'Restore purchases',
            variant: AppButtonVariant.ghost,
            onPressed: sub.isLoading
                ? null
                : () => ref
                      .read(subscriptionProvider.notifier)
                      .restorePurchases(),
          ),
          AppButton(
            label: 'No thanks',
            variant: AppButtonVariant.ghost,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.title, required this.price, this.badge});

  final String title;
  final String price;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(price),
              ],
            ),
          ),
          if (badge != null) Chip(label: Text(badge!)),
        ],
      ),
    );
  }
}
