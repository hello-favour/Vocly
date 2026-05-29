import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../session/app_session_provider.dart';
import '../data/lessons_repository.dart';
import '../models/lesson.dart';

final lessonsRepositoryProvider = Provider((ref) => LessonsRepository());

final todaysLessonsProvider = FutureProvider<List<Lesson>>((ref) {
  final level =
      ref.watch(appSessionProvider).valueOrNull?.skillLevel ?? 'intermediate';
  return ref.watch(lessonsRepositoryProvider).todaysLessons(level);
});

final lessonByIdProvider = Provider.family<Lesson?, String>((ref, id) {
  final lessons =
      ref.watch(todaysLessonsProvider).valueOrNull ?? const <Lesson>[];
  return lessons.where((lesson) => lesson.id == id).firstOrNull;
});
