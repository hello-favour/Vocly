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
