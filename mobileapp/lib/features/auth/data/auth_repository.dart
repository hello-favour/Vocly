import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../config/env.dart';
import '../../../core/exceptions/app_exceptions.dart';
import '../../session/app_session.dart';

class AuthRepository {
  bool get isConfigured => Env.hasSupabase;

  sb.SupabaseClient? get _client {
    if (!isConfigured) return null;
    try {
      return sb.Supabase.instance.client;
    } catch (_) {
      return null;
    }
  }

  Future<AppSession?> currentSession() async {
    final client = _client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return null;
    return _sessionFromProfile(client, user);
  }

  Future<AppSession> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final client = _requireClient();
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw const AuthException('Unable to sign in.');
    }
    return _sessionFromProfile(client, user);
  }

  Future<AppSession> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final client = _requireClient();
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': name},
    );
    final user = response.user;
    if (user == null) {
      throw const AuthException('Unable to create account.');
    }
    return _sessionFromProfile(client, user, displayName: name);
  }

  Future<void> signInWithGoogle() async {
    final client = _requireClient();
    await client.auth.signInWithOAuth(
      sb.OAuthProvider.google,
      redirectTo: 'com.vocly.app://login-callback',
    );
  }

  Future<AppSession> completeOnboarding({
    required String displayName,
    required String skillLevel,
    required String goal,
    required int dailyGoalMinutes,
  }) async {
    final client = _requireClient();
    final user = client.auth.currentUser;
    if (user == null) throw const AuthException('You need to sign in first.');

    await client
        .from('profiles')
        .update({
          'display_name': displayName,
          'skill_level': skillLevel,
          'goal': goal,
          'daily_goal_mins': dailyGoalMinutes,
          'onboarding_done': true,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);

    return _sessionFromProfile(client, user);
  }

  Future<void> markActivity({int coins = 0}) async {
    final client = _client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;
    await client.rpc('update_streak', params: {'p_user_id': user.id});
    if (coins > 0) {
      final session = await _sessionFromProfile(client, user);
      await client
          .from('profiles')
          .update({'coins': session.coins + coins})
          .eq('id', user.id);
    }
  }

  Future<void> signOut() async {
    await _client?.auth.signOut();
  }

  sb.SupabaseClient _requireClient() {
    final client = _client;
    if (client == null) {
      throw const SupabaseException('Supabase is not configured.');
    }
    return client;
  }

  Future<AppSession> _sessionFromProfile(
    sb.SupabaseClient client,
    sb.User user, {
    String displayName = '',
  }) async {
    final profile = await client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    final data = profile ?? <String, dynamic>{};

    return AppSession.empty.copyWith(
      isSignedIn: true,
      onboardingComplete: data['onboarding_done'] as bool? ?? false,
      displayName: data['display_name'] as String? ?? displayName,
      skillLevel: data['skill_level'] as String? ?? 'intermediate',
      goal: data['goal'] as String? ?? 'professional',
      dailyGoalMinutes: data['daily_goal_mins'] as int? ?? 10,
      streakCount: data['streak_count'] as int? ?? 0,
      coins: data['coins'] as int? ?? 0,
      streakFreeze: data['streak_freeze'] as int? ?? 0,
      isPro: data['is_pro'] as bool? ?? false,
    );
  }
}
