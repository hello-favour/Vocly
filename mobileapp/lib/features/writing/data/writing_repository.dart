import 'package:dio/dio.dart';

import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_client.dart';
import '../models/feedback_result.dart';
import '../models/writing_issue.dart';

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

    return FeedbackResult(
      original: text,
      corrected: _polishDemoText(text),
      tone: text.contains('kindly') ? 'formal' : 'neutral',
      overallScore: text.length > 80 ? 84 : 72,
      confidenceTip: 'Lead with the action you want the reader to take.',
      summary:
          'Clear foundation. A few word-choice changes make it sound more professional.',
      issues: const [
        WritingIssue(
          type: 'clarity',
          original: 'long opening',
          suggestion: 'state the request first',
          explanation:
              'Professional writing is easier to act on when the main request appears early.',
        ),
        WritingIssue(
          type: 'tone',
          original: 'too casual',
          suggestion: 'use a direct but polite phrase',
          explanation:
              'A balanced tone sounds confident without sounding rude.',
        ),
      ],
    );
  }

  String _polishDemoText(String text) {
    final trimmed = text.trim();
    if (trimmed.endsWith('.')) return trimmed;
    return '$trimmed.';
  }
}
