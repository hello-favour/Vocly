import '../models/user_stats.dart';

class ProgressRepository {
  Future<UserStats> loadStats() async {
    return const UserStats(
      wordsLearned: 12,
      writingScores: [62, 68, 71, 78, 84],
      pronunciationScores: [58, 64, 70, 76, 82],
    );
  }
}
