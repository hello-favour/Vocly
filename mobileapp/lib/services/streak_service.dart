import '../core/network/api_client.dart';

class StreakService {
  StreakService({ApiClient? apiClient}) : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<void> updateStreak() async {
    if (!_apiClient.isConfigured || !_apiClient.hasAuthToken) return;
    await _apiClient.postJson('/update-streak');
  }
}
