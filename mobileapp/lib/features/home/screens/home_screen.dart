import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../lessons/screens/lessons_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../progress/screens/progress_screen.dart';
import '../../pronunciation/screens/pronunciation_screen.dart';
import '../../session/app_session_provider.dart';
import '../../writing/screens/writing_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.tab});

  final String tab;

  static const tabs = [
    'lessons',
    'writing',
    'pronunciation',
    'progress',
    'profile',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = tabs.indexOf(tab).clamp(0, tabs.length - 1);
    final session =
        ref.watch(appSessionProvider).valueOrNull ?? AppSession.empty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FluentAI'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Chip(
              avatar: const Icon(Icons.local_fire_department, size: 18),
              label: Text('${session.streakCount}'),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: const [
          LessonsScreen(),
          WritingScreen(),
          PronunciationScreen(),
          ProgressScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (next) => context.go('/home/${tabs[next]}'),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Lessons',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Writing',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic_none),
            selectedIcon: Icon(Icons.mic),
            label: 'Speak',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
