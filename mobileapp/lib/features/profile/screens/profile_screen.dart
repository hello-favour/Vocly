import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/section_label.dart';
import 'package:mobileapp/core/widgets/settings_row.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/core/widgets/user_avatar.dart';
import 'package:mobileapp/features/profile/widgets/profile_row.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
    final name = session.displayName.isEmpty
        ? 'Paul Jeremiah'
        : session.displayName;

    return AppScreen(
      children: [
        Row(
          children: [
            UserAvatar(name: name, size: 46),
            const SizedBox(width: AppSpacings.elementSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.headline(name, context, fontWeight: FontWeight.w700),
                  const SizedBox(height: AppSpacings.elementSpacingTiny),
                  AppTexts.caption1(
                    'paul@example.com',
                    context,
                    color: AppColors.textTertiary,
                  ),
                ],
              ),
            ),
            AppPill(label: session.isPro ? 'Pro' : 'Free'),
          ],
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        AppCard(
          child: Column(
            children: [
              ProfileRow(label: 'Level', value: session.skillLevel),
              ProfileRow(label: 'Goal', value: session.goal),
              ProfileRow(
                label: 'Daily target',
                value: '${session.dailyGoalMinutes} min',
              ),
              const Divider(color: AppColors.border),
              ProfileRow(
                label: 'Streak freezes',
                value:
                    '${session.streakFreeze == 0 ? 2 : session.streakFreeze} available',
                icon: Icons.shield_outlined,
              ),
            ],
          ),
        ),
        const SectionLabel('Account'),
        SettingsRow(title: 'Edit profile', onTap: () {}),
        SettingsRow(
          title: 'Manage subscription',
          onTap: () => context.push(AppRoutes.paywall, extra: 'profile'),
        ),
        SettingsRow(title: 'Restore purchases', onTap: () {}),
        SettingsRow(
          title: 'Coins & rewards',
          onTap: () => context.push(AppRoutes.coins),
        ),
        SettingsRow(
          title: 'Settings',
          onTap: () => context.push(AppRoutes.settings),
        ),
      ],
    );
  }
}
