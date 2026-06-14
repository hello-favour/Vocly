import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_strings.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_snackbar.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/features/paywall/providers/subscription_provider.dart';
import 'package:mobileapp/features/paywall/widgets/paywall_feature_row.dart';
import 'package:mobileapp/features/paywall/widgets/paywall_plan_card.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key, this.trigger});

  final String? trigger;

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  String? selectedPackageId;

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionProvider);
    final data = subscription.valueOrNull;
    final packages = data?.packages ?? const <Package>[];
    final selectedPackage = _selectedPackage(packages);

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
          const Center(
            child: Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.primary,
              size: 72,
            ),
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppTexts.title2('Unlock Vocly Pro', context, center: true),
          const SizedBox(height: AppSpacings.elementSpacingTiny),
          AppTexts.body(
            'Keep learning after your free daily upgrades.',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          if (widget.trigger != null) ...[
            const SizedBox(height: AppSpacings.elementSpacing),
            const Center(child: AppPill(label: 'Daily limit reached')),
          ],
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          const PaywallFeatureRow('Unlimited Basic → Pro lessons'),
          const PaywallFeatureRow('Unlimited speaking practice'),
          const PaywallFeatureRow(
            'Every professional phrase and future update',
          ),
          const SizedBox(height: AppSpacings.elementSpacingLarge),
          if (subscription.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (subscription.hasError)
            _PaywallMessage(
              message: 'Could not load subscription plans. Please try again.',
              onRetry: () => ref.invalidate(subscriptionProvider),
            )
          else if (data?.isConfigured != true)
            const _PaywallMessage(
              message:
                  'Store billing is not configured on this build yet. Add your RevenueCat keys to enable payments.',
            )
          else if (packages.isEmpty)
            _PaywallMessage(
              message:
                  'No subscription products are available. Check the current RevenueCat offering.',
              onRetry: () => ref.invalidate(subscriptionProvider),
            )
          else
            for (final package in packages) ...[
              PaywallPlanCard(
                title: _packageTitle(package),
                subtitle: _packageSubtitle(package),
                price: package.storeProduct.priceString,
                badge: package.packageType == PackageType.annual
                    ? 'Best value'
                    : null,
                selected: package.identifier == selectedPackage?.identifier,
                onTap: () =>
                    setState(() => selectedPackageId = package.identifier),
              ),
              const SizedBox(height: AppSpacings.elementSpacing),
            ],
          const SizedBox(height: AppSpacings.elementSpacing),
          AppButton(
            label: data?.isPurchasing == true
                ? 'Processing payment...'
                : selectedPackage == null
                ? 'Choose a plan'
                : 'Continue with ${_packageTitle(selectedPackage)}',
            onPressed: selectedPackage == null || data?.isPurchasing == true
                ? null
                : () => _purchase(selectedPackage),
          ),
          const SizedBox(height: AppSpacings.elementSpacing),
          AppButton(
            label: 'Restore purchases',
            variant: AppButtonVariant.ghost,
            onPressed: data?.isConfigured == true && data?.isPurchasing != true
                ? _restore
                : null,
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.caption1(
            'Payment is handled securely by Apple or Google. '
            'Subscriptions renew automatically until cancelled.',
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
          const SizedBox(height: AppSpacings.elementSpacingSmall),
          AppTexts.caption2(
            AppStrings.tagline,
            context,
            color: AppColors.textTertiary,
            center: true,
          ),
        ],
      ),
    );
  }

  Package? _selectedPackage(List<Package> packages) {
    if (packages.isEmpty) return null;
    if (selectedPackageId == null) return packages.first;
    return packages
        .where((package) => package.identifier == selectedPackageId)
        .firstOrNull;
  }

  Future<void> _purchase(Package package) async {
    final success = await ref
        .read(subscriptionProvider.notifier)
        .purchase(package);
    if (!mounted) return;

    final message = ref.read(subscriptionProvider).valueOrNull?.message;
    if (success) {
      ref.read(appSessionProvider.notifier).setPro(true);
      AppSnackbar.showSnackBar(
        context,
        message: message ?? 'Welcome to Vocly Pro.',
        type: SnackBarType.success,
      );
      Navigator.of(context).pop();
    } else if (message != null) {
      AppSnackbar.showSnackBar(
        context,
        message: message,
        type: SnackBarType.error,
      );
    }
  }

  Future<void> _restore() async {
    final success = await ref
        .read(subscriptionProvider.notifier)
        .restorePurchases();
    if (!mounted) return;

    final message = ref.read(subscriptionProvider).valueOrNull?.message;
    if (success) ref.read(appSessionProvider.notifier).setPro(true);
    AppSnackbar.showSnackBar(
      context,
      message: message ?? 'Restore completed.',
      type: success ? SnackBarType.success : SnackBarType.info,
    );
  }
}

class _PaywallMessage extends StatelessWidget {
  const _PaywallMessage({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacings.elementSpacing),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppSpacings.defaultBorderRadiusTextField,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          AppTexts.body(
            message,
            context,
            color: AppColors.textSecondary,
            center: true,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacings.elementSpacingSmall),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ],
      ),
    );
  }
}

String _packageTitle(Package package) => switch (package.packageType) {
  PackageType.annual => 'Yearly',
  PackageType.monthly => 'Monthly',
  PackageType.lifetime => 'Lifetime',
  PackageType.weekly => 'Weekly',
  _ => package.storeProduct.title,
};

String _packageSubtitle(Package package) => switch (package.packageType) {
  PackageType.annual => 'Best for building a lasting speaking habit',
  PackageType.monthly => 'Flexible monthly access',
  PackageType.lifetime => 'One payment, permanent access',
  _ => package.storeProduct.description,
};
