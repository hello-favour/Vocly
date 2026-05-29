class UserStats {
  const UserStats({
    required this.wordsLearned,
    required this.writingScores,
    required this.pronunciationScores,
  });

  final int wordsLearned;
  final List<int> writingScores;
  final List<int> pronunciationScores;
}
