import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/writing_repository.dart';
import '../models/feedback_result.dart';

final writingRepositoryProvider = Provider((ref) => WritingRepository(Dio()));

final writingCheckProvider =
    AsyncNotifierProvider<WritingCheckNotifier, FeedbackResult?>(
      WritingCheckNotifier.new,
    );

class WritingCheckNotifier extends AsyncNotifier<FeedbackResult?> {
  @override
  Future<FeedbackResult?> build() async => null;

  Future<FeedbackResult> check(String text) async {
    state = const AsyncLoading();
    final result = await ref.read(writingRepositoryProvider).checkWriting(text);
    state = AsyncData(result);
    return result;
  }
}
