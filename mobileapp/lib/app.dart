import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router.dart';
import 'core/theme/theme_data.dart';

class FluentAiApp extends StatelessWidget {
  const FluentAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _FluentAiMaterialApp());
  }
}

class _FluentAiMaterialApp extends ConsumerWidget {
  const _FluentAiMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Vocly',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.themeLight,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
