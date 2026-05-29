import '../config/supabase_config.dart';

class StreakService {
  Future<void> updateStreak() async {
    final client = SupabaseConfig.maybeClient;
    final user = client?.auth.currentUser;
    if (client == null || user == null) return;
    await client.rpc('update_streak', params: {'p_user_id': user.id});
  }
}
