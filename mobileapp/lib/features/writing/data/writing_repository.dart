import 'package:dio/dio.dart';

import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_client.dart';
import '../models/feedback_result.dart';

class WritingRepository {
  WritingRepository([ApiClient? apiClient])
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;

  Future<FeedbackResult> checkWriting(String text) async {
    if (_apiClient.isConfigured) {
      try {
        final response = await _apiClient.postJson(
          '/check-writing',
          data: {'text': text},
        );
        return FeedbackResult.fromJson(response, original: text);
      } on DioException catch (error) {
        final data = error.response?.data;
        final code = data is Map ? data['error'] : null;
        if (error.response?.statusCode == 429 || code == 'FREE_LIMIT_REACHED') {
          throw const FreeLimitReachedException('writing');
        }
        throw NetworkException(error.message ?? 'Writing check failed.');
      }
    }

    throw const NetworkException(
      'Vocly is not connected to the writing service.',
    );
  }
}
