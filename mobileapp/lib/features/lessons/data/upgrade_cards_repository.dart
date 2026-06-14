import 'package:dio/dio.dart';

import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_client.dart';
import '../models/upgrade_card.dart';

class UpgradeCardsRepository {
  UpgradeCardsRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<List<UpgradeCard>> todaysCards({
    required String level,
    required String domain,
  }) async {
    if (!_apiClient.isConfigured) {
      throw const NetworkException(
        'Vocly is not connected to Supabase. Check the app configuration.',
      );
    }

    try {
      final payload = await _apiClient.getJson(
        '/get-upgrade-cards',
        queryParameters: {'level': level, 'domain': domain},
      );
      if (payload['limit_reached'] == true) {
        throw const FreeLimitReachedException('upgrades');
      }
      final rows = payload['upgrade_cards'] as List<dynamic>? ?? const [];
      return rows
          .map((row) => UpgradeCard.fromJson(row as Map<String, dynamic>))
          .toList();
    } on DioException catch (error) {
      if (error.response?.statusCode == 429) {
        throw const FreeLimitReachedException('upgrades');
      }
      throw NetworkException(error.message ?? 'Could not load upgrades.');
    }
  }

  Future<void> completeCard(String cardId) async {
    if (!_apiClient.isConfigured || !_apiClient.hasAuthToken) return;

    try {
      await _apiClient.postJson(
        '/complete-upgrade-card',
        data: {'card_id': cardId},
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 429) {
        throw const FreeLimitReachedException('upgrades');
      }
      throw NetworkException(error.message ?? 'Could not complete upgrade.');
    }
  }
}
