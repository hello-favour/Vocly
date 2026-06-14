import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router.dart';
import 'core/theme/theme_data.dart';

class VoclyApp extends StatelessWidget {
  const VoclyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _VoclyMaterialApp());
  }
}

class _VoclyMaterialApp extends ConsumerWidget {
  const _VoclyMaterialApp();

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
