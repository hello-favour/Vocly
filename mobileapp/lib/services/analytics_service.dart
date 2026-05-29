import 'package:posthog_flutter/posthog_flutter.dart';

class AnalyticsService {
  static void track(String event, [Map<String, Object>? properties]) {
    Posthog().capture(eventName: event, properties: properties);
  }

  static void identify(String userId, Map<String, Object> props) {
    Posthog().identify(userId: userId, userPropertiesSetOnce: props);
  }
}
