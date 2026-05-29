class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const revenueCatApple = String.fromEnvironment('REVENUECAT_APPLE_KEY');
  static const revenueCatGoogle = String.fromEnvironment(
    'REVENUECAT_GOOGLE_KEY',
  );
  static const posthogKey = String.fromEnvironment('POSTHOG_API_KEY');
  static const posthogHost = String.fromEnvironment('POSTHOG_HOST');

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
