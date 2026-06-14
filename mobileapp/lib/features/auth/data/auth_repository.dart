import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:purchases_flutter/purchases_flutter.dart';

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
    await _identifyPurchaser(user.id);
    return _sessionFromProfile(client, user);
  }

  Future<AppSession> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final client = _requireClient();
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthException('Unable to sign in.');
      }
      await _identifyPurchaser(user.id);
      return _sessionFromProfile(client, user);
    } on sb.AuthException catch (error) {
      throw AuthException(_authMessage(error));
    }
  }

  Future<AppSession?> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final client = _requireClient();
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name},
        emailRedirectTo: 'com.vocly.app:///auth/login',
      );
      final user = response.user;
      if (user == null) {
        throw const AuthException('Unable to create account.');
      }
      if (response.session == null) return null;
      await _identifyPurchaser(user.id);
      return _sessionFromProfile(client, user, displayName: name);
    } on sb.AuthException catch (error) {
      throw AuthException(_authMessage(error));
    }
  }

  Future<void> signInWithGoogle() async {
    final client = _requireClient();
    await client.auth.signInWithOAuth(
      sb.OAuthProvider.google,
      redirectTo: 'com.vocly.app:///auth/login',
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final client = _requireClient();
    try {
      await client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'com.vocly.app:///auth/reset-password',
      );
    } on sb.AuthException catch (error) {
      throw AuthException(_authMessage(error));
    }
  }

  Future<void> updatePassword(String password) async {
    final client = _requireClient();
    if (client.auth.currentSession == null) {
      throw const AuthException(
        'This reset link is invalid or has expired. Request a new one.',
      );
    }
    try {
      await client.auth.updateUser(sb.UserAttributes(password: password));
    } on sb.AuthException catch (error) {
      throw AuthException(_authMessage(error));
    }
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

  Future<void> markActivity() async {
    final client = _client;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;
    await client.rpc('update_streak', params: {'p_user_id': user.id});
  }

  Future<void> signOut() async {
    if (Env.hasRevenueCat) {
      try {
        await Purchases.logOut();
      } catch (_) {
        // RevenueCat can already be anonymous before the first account login.
      }
    }
    await _client?.auth.signOut();
  }

  Future<void> _identifyPurchaser(String userId) async {
    if (!Env.hasRevenueCat) return;
    try {
      await Purchases.logIn(userId);
    } catch (_) {
      // Authentication should still work if store services are unavailable.
    }
  }

  String _authMessage(sb.AuthException error) {
    final message = error.message.toLowerCase();
    if (message.contains('invalid login credentials')) {
      return 'Incorrect email or password.';
    }
    if (message.contains('email not confirmed')) {
      return 'Confirm your email before signing in.';
    }
    if (message.contains('user already registered')) {
      return 'An account already exists for this email.';
    }
    if (message.contains('password')) {
      return 'Your password does not meet the security requirements.';
    }
    if (message.contains('rate limit')) {
      return 'Too many attempts. Please wait and try again.';
    }
    return error.message;
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
