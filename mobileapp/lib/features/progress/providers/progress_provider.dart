import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/progress_repository.dart';
import '../models/user_stats.dart';

final progressRepositoryProvider = Provider((ref) => ProgressRepository());
final progressProvider = FutureProvider<UserStats>(
  (ref) => ref.watch(progressRepositoryProvider).loadStats(),
);
