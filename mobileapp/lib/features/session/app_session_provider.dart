import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  const AppSession({
    required this.isSignedIn,
    required this.onboardingComplete,
    required this.displayName,
    required this.skillLevel,
    required this.goal,
    required this.dailyGoalMinutes,
    required this.streakCount,
    required this.coins,
    required this.streakFreeze,
    required this.isPro,
  });

  final bool isSignedIn;
  final bool onboardingComplete;
  final String displayName;
  final String skillLevel;
  final String goal;
  final int dailyGoalMinutes;
  final int streakCount;
  final int coins;
  final int streakFreeze;
  final bool isPro;

  AppSession copyWith({
    bool? isSignedIn,
    bool? onboardingComplete,
    String? displayName,
    String? skillLevel,
    String? goal,
    int? dailyGoalMinutes,
    int? streakCount,
    int? coins,
    int? streakFreeze,
    bool? isPro,
  }) {
    return AppSession(
      isSignedIn: isSignedIn ?? this.isSignedIn,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      displayName: displayName ?? this.displayName,
      skillLevel: skillLevel ?? this.skillLevel,
      goal: goal ?? this.goal,
      dailyGoalMinutes: dailyGoalMinutes ?? this.dailyGoalMinutes,
      streakCount: streakCount ?? this.streakCount,
      coins: coins ?? this.coins,
      streakFreeze: streakFreeze ?? this.streakFreeze,
      isPro: isPro ?? this.isPro,
    );
  }

  static const empty = AppSession(
    isSignedIn: false,
    onboardingComplete: false,
    displayName: '',
    skillLevel: 'intermediate',
    goal: 'professional',
    dailyGoalMinutes: 10,
    streakCount: 0,
    coins: 0,
    streakFreeze: 0,
    isPro: false,
  );
}

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

  Future<void> signIn({String name = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_signedInKey, true);
    state = AsyncData(
      (state.value ?? AppSession.empty).copyWith(
        isSignedIn: true,
        displayName: name,
      ),
    );
  }

  Future<void> signOut() async {
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
