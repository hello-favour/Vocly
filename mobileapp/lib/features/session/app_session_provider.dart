import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/env.dart';
import '../../core/exceptions/app_exceptions.dart';
import '../auth/data/auth_repository.dart';
import 'app_session.dart';

export 'app_session.dart';

final appSessionProvider =
    AsyncNotifierProvider<AppSessionNotifier, AppSession>(
      AppSessionNotifier.new,
    );

class AppSessionNotifier extends AsyncNotifier<AppSession> {
  @override
  Future<AppSession> build() async {
    if (Env.hasSupabase) {
      final subscription = Supabase.instance.client.auth.onAuthStateChange
          .listen((event) async {
            if (event.event == AuthChangeEvent.signedOut) {
              state = const AsyncData(AppSession.empty);
              return;
            }
            if (event.session != null) {
              final session = await AuthRepository().currentSession();
              if (session != null) state = AsyncData(session);
            }
          });
      ref.onDispose(subscription.cancel);
    }

    final remoteSession = await AuthRepository().currentSession();
    if (remoteSession != null) return remoteSession;
    return AppSession.empty;
  }

  Future<void> signIn({String email = '', String password = ''}) async {
    final authRepository = AuthRepository();
    if (!authRepository.isConfigured) {
      throw const SupabaseException(
        'Supabase is not configured. Add the project URL and publishable key.',
      );
    }
    final previous = state.value ?? AppSession.empty;
    state = const AsyncLoading();
    try {
      final session = await authRepository.signInWithEmail(
        email: email,
        password: password,
      );
      state = AsyncData(session);
    } catch (error, stackTrace) {
      state = AsyncData(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final authRepository = AuthRepository();
    if (!authRepository.isConfigured) {
      throw const SupabaseException(
        'Supabase is not configured. Add the project URL and publishable key.',
      );
    }
    final previous = state.value ?? AppSession.empty;
    state = const AsyncLoading();
    try {
      final session = await authRepository.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      if (session == null) {
        state = AsyncData(previous);
        return false;
      }
      state = AsyncData(session);
      return true;
    } catch (error, stackTrace) {
      state = AsyncData(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> signInWithGoogle() async {
    final authRepository = AuthRepository();
    if (!authRepository.isConfigured) {
      throw const SupabaseException(
        'Supabase is not configured. Add the project URL and publishable key.',
      );
    }

    await authRepository.signInWithGoogle();
    final remoteSession = await authRepository.currentSession();
    if (remoteSession != null) {
      state = AsyncData(remoteSession);
    }
  }

  Future<void> signOut() async {
    await AuthRepository().signOut();
    state = const AsyncData(AppSession.empty);
  }

  Future<void> completeOnboarding({
    required String displayName,
    required String skillLevel,
    required String goal,
    required int dailyGoalMinutes,
  }) async {
    final authRepository = AuthRepository();
    if (!authRepository.isConfigured) {
      throw const SupabaseException(
        'Supabase is not configured. Add the project URL and publishable key.',
      );
    }
    state = const AsyncLoading();
    final session = await authRepository.completeOnboarding(
      displayName: displayName,
      skillLevel: skillLevel,
      goal: goal,
      dailyGoalMinutes: dailyGoalMinutes,
    );
    state = AsyncData(session);
  }

  void markActivity({int coins = 0}) {
    unawaited(AuthRepository().markActivity());
    _applyActivityLocally(coins: coins);
  }

  void applyServerActivity({int coins = 0}) {
    _applyActivityLocally(coins: coins);
  }

  void _applyActivityLocally({required int coins}) {
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
