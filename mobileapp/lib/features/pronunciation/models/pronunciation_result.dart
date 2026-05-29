class PronunciationResult {
  const PronunciationResult({
    required this.word,
    required this.scoreOverall,
    this.phonemes = const [],
  });

  final String word;
  final int scoreOverall;
  final List<String> phonemes;
}
