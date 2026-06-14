import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/app_button.dart';
import 'package:mobileapp/core/widgets/app_card.dart';
import 'package:mobileapp/core/widgets/app_pill.dart';
import 'package:mobileapp/core/widgets/app_screen.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/core/widgets/user_avatar.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
    final name = session.displayName.isEmpty
        ? 'Vocly learner'
        : session.displayName;

    return AppScreen(
      children: [
        const SizedBox(height: AppSpacings.elementSpacing),
        Center(child: UserAvatar(name: name, size: 72)),
        const SizedBox(height: AppSpacings.elementSpacing),
        AppTexts.title2(name, context, center: true),
        const SizedBox(height: AppSpacings.elementSpacingSmall),
        Center(
          child: AppPill(label: session.isPro ? 'Vocly Pro' : 'Free plan'),
        ),
        const SizedBox(height: AppSpacings.sectionSpacing),
        AppCard(
          child: Column(
            children: [
              _ProfileDetail(
                label: 'Your focus',
                value: _goalLabel(session.goal),
              ),
              const Divider(color: AppColors.border),
              _ProfileDetail(
                label: 'Current streak',
                value: '${session.streakCount} days',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacings.elementSpacingLarge),
        if (!session.isPro)
          AppButton(
            label: 'Upgrade to Vocly Pro',
            onPressed: () => context.push(AppRoutes.paywall, extra: 'profile'),
          ),
        if (!session.isPro) const SizedBox(height: AppSpacings.elementSpacing),
        AppButton(
          label: 'Sign out',
          variant: AppButtonVariant.ghost,
          onPressed: () async {
            await ref.read(appSessionProvider.notifier).signOut();
            if (context.mounted) context.go(AppRoutes.authSplash);
          },
        ),
      ],
    );
  }
}

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacings.elementSpacingSmall,
      ),
      child: Row(
        children: [
          AppTexts.body(label, context, color: AppColors.textTertiary),
          const Spacer(),
          AppTexts.body(
            value,
            context,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

String _goalLabel(String goal) => switch (goal) {
  'social' => 'Natural conversations',
  'interview' => 'Job interviews',
  'all' => 'Every situation',
  _ => 'Professional English',
};
