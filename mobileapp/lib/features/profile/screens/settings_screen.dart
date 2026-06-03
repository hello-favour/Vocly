import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/app_toggle.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/settings_row.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: AppScreen(
        children: [
          const SectionLabel('Notifications'),
          const SettingsRow(
            title: 'Daily lesson reminder',
            subtitle: '8:00 AM every day',
            trailing: AppToggle(value: true),
          ),
          const SettingsRow(
            title: 'Streak warning',
            subtitle: '8:00 PM if no activity',
            trailing: AppToggle(value: true),
          ),
          const SettingsRow(
            title: 'Milestone celebrations',
            subtitle: '7, 14, 30, 100 day streaks',
            trailing: AppToggle(value: false),
          ),
          const SectionLabel('Preferences'),
          const SettingsRow(
            title: 'English dialect',
            subtitle: 'American English',
          ),
          const SettingsRow(title: 'Daily reminder time', subtitle: '8:00 AM'),
          const SectionLabel('Support'),
          const SettingsRow(title: 'Help & FAQ'),
          SettingsRow(
            title: 'Sign out',
            danger: true,
            onTap: () async {
              await ref.read(appSessionProvider.notifier).signOut();
              if (context.mounted) context.go(AppRoutes.authSplash);
            },
          ),
        ],
      ),
    );
  }
}
