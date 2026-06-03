import 'package:posthog_flutter/posthog_flutter.dart';

class AnalyticsService {
  static Future<void> init({
    required String apiKey,
    required String host,
  }) async {
    if (apiKey.isEmpty) return;
    final config = PostHogConfig(apiKey);
    if (host.isNotEmpty) config.host = host;
    await Posthog().setup(config);
  }

  static void track(String event, [Map<String, Object>? properties]) {
    Posthog().capture(eventName: event, properties: properties);
  }

  static void identify(String userId, Map<String, Object> props) {
    Posthog().identify(userId: userId, userPropertiesSetOnce: props);
  }
}
