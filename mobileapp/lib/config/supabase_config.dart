import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';

class SupabaseConfig {
  static Future<void> init() async {
    if (!Env.hasSupabase) return;

    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
  }

  static SupabaseClient? get maybeClient {
    if (!Env.hasSupabase) return null;
    return Supabase.instance.client;
  }
}
