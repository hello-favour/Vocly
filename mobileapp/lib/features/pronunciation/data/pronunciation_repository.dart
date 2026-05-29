import '../models/pronunciation_result.dart';

class PronunciationRepository {
  Future<PronunciationResult> scoreWord(String word) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final score = 58 + (word.trim().length * 4).clamp(0, 34);
    return PronunciationResult(word: word.trim(), scoreOverall: score);
  }
}
