import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../session/app_session_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                session.displayName.isEmpty
                    ? 'FluentAI learner'
                    : session.displayName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '${session.skillLevel} • ${session.goal} • ${session.dailyGoalMinutes} min/day',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('${session.coins} coins')),
                  Chip(label: Text('${session.streakFreeze} freezes')),
                  Chip(label: Text(session.isPro ? 'Pro' : 'Free')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppButton(
          label: 'Upgrade to Pro',
          icon: Icons.workspace_premium,
          onPressed: () => context.push('/paywall', extra: 'profile'),
        ),
        const SizedBox(height: 8),
        AppButton(
          label: 'Sign out',
          icon: Icons.logout,
          variant: AppButtonVariant.secondary,
          onPressed: () async {
            await ref.read(appSessionProvider.notifier).signOut();
            if (context.mounted) context.go('/auth/login');
          },
        ),
      ],
    );
  }
}
