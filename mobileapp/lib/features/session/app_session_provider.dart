import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/data/auth_repository.dart';
import 'app_session.dart';

export 'app_session.dart';

final appSessionProvider =
    AsyncNotifierProvider<AppSessionNotifier, AppSession>(
      AppSessionNotifier.new,
    );

class AppSessionNotifier extends AsyncNotifier<AppSession> {
  static const _signedInKey = 'signed_in';
  static const _onboardingKey = 'onboarding_complete';
  static const _nameKey = 'display_name';
  static const _levelKey = 'skill_level';
  static const _goalKey = 'goal';
  static const _minutesKey = 'daily_goal_minutes';

  @override
  Future<AppSession> build() async {
    final remoteSession = await AuthRepository().currentSession();
    if (remoteSession != null) return remoteSession;

    final prefs = await SharedPreferences.getInstance();
    return AppSession.empty.copyWith(
      isSignedIn: prefs.getBool(_signedInKey) ?? false,
      onboardingComplete: prefs.getBool(_onboardingKey) ?? false,
      displayName: prefs.getString(_nameKey) ?? '',
      skillLevel: prefs.getString(_levelKey) ?? 'intermediate',
      goal: prefs.getString(_goalKey) ?? 'professional',
      dailyGoalMinutes: prefs.getInt(_minutesKey) ?? 10,
    );
  }

  Future<void> signIn({
    String name = '',
    String email = '',
    String password = '',
  }) async {
    final authRepository = AuthRepository();
    if (authRepository.isConfigured &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      state = const AsyncLoading();
      final session = await authRepository.signInWithEmail(
        email: email,
        password: password,
      );
      state = AsyncData(session);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_signedInKey, true);
    state = AsyncData(
      (state.value ?? AppSession.empty).copyWith(
        isSignedIn: true,
        displayName: name,
      ),
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final authRepository = AuthRepository();
    if (authRepository.isConfigured) {
      state = const AsyncLoading();
      final session = await authRepository.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      state = AsyncData(session);
      return;
    }

    await signIn(name: name);
  }

  Future<void> signInWithGoogle() async {
    final authRepository = AuthRepository();
    if (!authRepository.isConfigured) {
      await signIn(name: 'Paul');
      return;
    }

    await authRepository.signInWithGoogle();
    final remoteSession = await authRepository.currentSession();
    if (remoteSession != null) {
      state = AsyncData(remoteSession);
    }
  }

  Future<void> signOut() async {
    await AuthRepository().signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_signedInKey, false);
    state = AsyncData(
      (state.value ?? AppSession.empty).copyWith(isSignedIn: false),
    );
  }

  Future<void> completeOnboarding({
    required String displayName,
    required String skillLevel,
    required String goal,
    required int dailyGoalMinutes,
  }) async {
    final authRepository = AuthRepository();
    if (authRepository.isConfigured) {
      state = const AsyncLoading();
      final session = await authRepository.completeOnboarding(
        displayName: displayName,
        skillLevel: skillLevel,
        goal: goal,
        dailyGoalMinutes: dailyGoalMinutes,
      );
      state = AsyncData(session);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
    await prefs.setString(_nameKey, displayName);
    await prefs.setString(_levelKey, skillLevel);
    await prefs.setString(_goalKey, goal);
    await prefs.setInt(_minutesKey, dailyGoalMinutes);
    state = AsyncData(
      (state.value ?? AppSession.empty).copyWith(
        isSignedIn: true,
        onboardingComplete: true,
        displayName: displayName,
        skillLevel: skillLevel,
        goal: goal,
        dailyGoalMinutes: dailyGoalMinutes,
        streakCount: 1,
        coins: 10,
      ),
    );
  }

  void markActivity({int coins = 0}) {
    unawaited(AuthRepository().markActivity(coins: coins));
    final current = state.value ?? AppSession.empty;
    state = AsyncData(
      current.copyWith(
        streakCount: current.streakCount == 0 ? 1 : current.streakCount,
        coins: current.coins + coins,
      ),
    );
  }

  void setPro(bool value) {
    final current = state.value ?? AppSession.empty;
    state = AsyncData(current.copyWith(isPro: value));
  }
}
