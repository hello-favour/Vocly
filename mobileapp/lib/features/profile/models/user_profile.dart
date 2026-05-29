class UserProfile {
  const UserProfile({
    required this.displayName,
    required this.goal,
    required this.skillLevel,
    required this.dailyGoalMinutes,
    required this.coins,
    required this.streakFreeze,
    required this.isPro,
  });

  final String displayName;
  final String goal;
  final String skillLevel;
  final int dailyGoalMinutes;
  final int coins;
  final int streakFreeze;
  final bool isPro;
}
