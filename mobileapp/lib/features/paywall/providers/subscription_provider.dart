import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../config/env.dart';

class SubscriptionState {
  const SubscriptionState({
    required this.isConfigured,
    required this.isPro,
    required this.packages,
    this.isPurchasing = false,
    this.message,
  });

  final bool isConfigured;
  final bool isPro;
  final List<Package> packages;
  final bool isPurchasing;
  final String? message;

  SubscriptionState copyWith({
    bool? isConfigured,
    bool? isPro,
    List<Package>? packages,
    bool? isPurchasing,
    String? message,
    bool clearMessage = false,
  }) {
    return SubscriptionState(
      isConfigured: isConfigured ?? this.isConfigured,
      isPro: isPro ?? this.isPro,
      packages: packages ?? this.packages,
      isPurchasing: isPurchasing ?? this.isPurchasing,
      message: clearMessage ? null : message ?? this.message,
    );
  }
}

final subscriptionProvider =
    AsyncNotifierProvider<SubscriptionNotifier, SubscriptionState>(
      SubscriptionNotifier.new,
    );

class SubscriptionNotifier extends AsyncNotifier<SubscriptionState> {
  @override
  Future<SubscriptionState> build() async {
    if (!Env.hasRevenueCat) {
      return const SubscriptionState(
        isConfigured: false,
        isPro: false,
        packages: [],
      );
    }

    final results = await Future.wait([
      Purchases.getCustomerInfo(),
      Purchases.getOfferings(),
    ]);
    final customerInfo = results[0] as CustomerInfo;
    final offerings = results[1] as Offerings;
    final packages = [...?offerings.current?.availablePackages]
      ..sort((a, b) => _packageOrder(a).compareTo(_packageOrder(b)));

    return SubscriptionState(
      isConfigured: true,
      isPro: _hasPro(customerInfo),
      packages: packages,
    );
  }

  Future<bool> purchase(Package package) async {
    final current = state.valueOrNull;
    if (current == null || !current.isConfigured) return false;

    state = AsyncData(current.copyWith(isPurchasing: true, clearMessage: true));
    try {
      final info = await Purchases.purchasePackage(package);
      final isPro = _hasPro(info);
      state = AsyncData(
        current.copyWith(
          isPro: isPro,
          isPurchasing: false,
          message: isPro ? 'Welcome to Vocly Pro.' : null,
        ),
      );
      return isPro;
    } on PlatformException catch (error) {
      final code = PurchasesErrorHelper.getErrorCode(error);
      if (code == PurchasesErrorCode.purchaseCancelledError) {
        state = AsyncData(current.copyWith(isPurchasing: false));
        return false;
      }
      state = AsyncData(
        current.copyWith(
          isPurchasing: false,
          message: 'Payment could not be completed. Please try again.',
        ),
      );
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    final current = state.valueOrNull;
    if (current == null || !current.isConfigured) return false;

    state = AsyncData(current.copyWith(isPurchasing: true, clearMessage: true));
    try {
      final info = await Purchases.restorePurchases();
      final isPro = _hasPro(info);
      state = AsyncData(
        current.copyWith(
          isPro: isPro,
          isPurchasing: false,
          message: isPro
              ? 'Your Vocly Pro purchase was restored.'
              : 'No active Vocly Pro purchase was found.',
        ),
      );
      return isPro;
    } catch (_) {
      state = AsyncData(
        current.copyWith(
          isPurchasing: false,
          message: 'Could not restore purchases. Please try again.',
        ),
      );
      return false;
    }
  }
}

bool _hasPro(CustomerInfo info) => info.entitlements.active.containsKey('pro');

int _packageOrder(Package package) => switch (package.packageType) {
  PackageType.annual => 0,
  PackageType.monthly => 1,
  PackageType.lifetime => 2,
  _ => 3,
};
