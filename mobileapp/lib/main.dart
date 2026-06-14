import 'dart:io';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'config/env.dart';
import 'services/analytics_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Env.hasSupabase) {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseClientKey,
    );
  }

  if (Env.hasRevenueCat) {
    final apiKey = Platform.isIOS ? Env.revenueCatApple : Env.revenueCatGoogle;
    if (apiKey.isNotEmpty) {
      await Purchases.configure(PurchasesConfiguration(apiKey));
    }
  }

  await NotificationService.init();
  await AnalyticsService.init(apiKey: Env.posthogKey, host: Env.posthogHost);

  runApp(const VoclyApp());
}
