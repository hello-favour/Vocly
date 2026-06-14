import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobileapp/core/constants/app_colors.dart';
import 'package:mobileapp/core/constants/app_routes.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/streak_chip.dart';
import 'package:mobileapp/core/widgets/texts/app_texts.dart';
import 'package:mobileapp/core/widgets/user_avatar.dart';
import 'package:mobileapp/features/lessons/screens/lessons_screen.dart';
import 'package:mobileapp/features/profile/screens/profile_screen.dart';
import 'package:mobileapp/features/pronunciation/screens/pronunciation_screen.dart';
import 'package:mobileapp/features/session/app_session_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.tab});

  final String tab;

  static const tabs = ['lessons', 'pronunciation', 'profile'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = tabs.indexOf(tab).clamp(0, tabs.length - 1);
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;
    final name = session.displayName.trim();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacings.screenPadding,
        title: Row(
          children: [
            UserAvatar(name: name, size: 40),
            const SizedBox(width: AppSpacings.iconGap),
            Expanded(
              child: AppTexts.headline(
                index == 0
                    ? name.isEmpty
                          ? 'Ready to speak like a pro?'
                          : 'Ready to sound sharper, $name?'
                    : _titles[index],
                context,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacings.screenPadding),
            child: StreakChip(
              session.streakCount == 0 ? 12 : session.streakCount,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: const [
          LessonsScreen(),
          PronunciationScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          border: const Border(top: BorderSide(color: AppColors.border)),
        ),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (next) =>
              context.go(AppRoutes.homeTab(tabs[next])),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.mic_none),
              selectedIcon: Icon(Icons.mic),
              label: 'Speak',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

const _titles = ['Home', 'Speak like a pro', 'Profile'];
