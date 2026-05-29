import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final subscriptionProvider = AsyncNotifierProvider<SubscriptionNotifier, bool>(
  SubscriptionNotifier.new,
);

class SubscriptionNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey('pro');
    } catch (_) {
      return false;
    }
  }

  Future<void> restorePurchases() async {
    state = const AsyncLoading();
    try {
      final info = await Purchases.restorePurchases();
      state = AsyncData(info.entitlements.active.containsKey('pro'));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
