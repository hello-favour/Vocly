import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pronunciation_repository.dart';
import '../models/pronunciation_result.dart';

final pronunciationRepositoryProvider = Provider(
  (ref) => PronunciationRepository(),
);

final pronunciationScoreProvider =
    AsyncNotifierProvider<PronunciationScoreNotifier, PronunciationResult?>(
      PronunciationScoreNotifier.new,
    );

class PronunciationScoreNotifier extends AsyncNotifier<PronunciationResult?> {
  @override
  Future<PronunciationResult?> build() async => null;

  Future<PronunciationResult> score(String word) async {
    state = const AsyncLoading();
    final result = await ref
        .read(pronunciationRepositoryProvider)
        .scoreWord(word);
    state = AsyncData(result);
    return result;
  }
}
