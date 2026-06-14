import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pronunciation_repository.dart';
import '../models/pronunciation_result.dart';

final pronunciationRepositoryProvider = Provider((ref) {
  final repository = PronunciationRepository();
  ref.onDispose(repository.dispose);
  return repository;
});

final pronunciationScoreProvider =
    AsyncNotifierProvider<PronunciationScoreNotifier, PronunciationResult?>(
      PronunciationScoreNotifier.new,
    );

class PronunciationScoreNotifier extends AsyncNotifier<PronunciationResult?> {
  @override
  Future<PronunciationResult?> build() async => null;

  Future<void> startRecording() {
    return ref.read(pronunciationRepositoryProvider).startRecording();
  }

  Future<PronunciationResult> stopAndScore(String phrase) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(pronunciationRepositoryProvider)
          .stopAndScore(phrase);
      state = AsyncData(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
