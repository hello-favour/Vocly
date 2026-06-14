class Env {
  Env._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const backendBaseUrl = String.fromEnvironment('BACKEND_BASE_URL');
  static const backendAuthToken = String.fromEnvironment('BACKEND_AUTH_TOKEN');
  static const revenueCatApple = String.fromEnvironment('REVENUECAT_APPLE_KEY');
  static const revenueCatGoogle = String.fromEnvironment(
    'REVENUECAT_GOOGLE_KEY',
  );
  static const posthogKey = String.fromEnvironment('POSTHOG_API_KEY');
  static const posthogHost = String.fromEnvironment('POSTHOG_HOST');

  static String get apiBaseUrl {
    if (backendBaseUrl.isNotEmpty) return backendBaseUrl;
    if (supabaseUrl.isNotEmpty) return '$supabaseUrl/functions/v1';
    return '';
  }

  static bool get hasBackend => apiBaseUrl.isNotEmpty;

  static String get supabaseClientKey => supabasePublishableKey.isNotEmpty
      ? supabasePublishableKey
      : supabaseAnonKey;

  static bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseClientKey.isNotEmpty;

  static bool get hasRevenueCat =>
      revenueCatApple.isNotEmpty || revenueCatGoogle.isNotEmpty;

  static bool get hasPostHog => posthogKey.isNotEmpty;
}
