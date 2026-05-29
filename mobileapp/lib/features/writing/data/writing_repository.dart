import 'package:dio/dio.dart';

import '../../../config/env.dart';
import '../../../config/supabase_config.dart';
import '../models/feedback_result.dart';
import '../models/writing_issue.dart';

class WritingRepository {
  WritingRepository(this._dio);

  final Dio _dio;

  Future<FeedbackResult> checkWriting(String text) async {
    final client = SupabaseConfig.maybeClient;
    final session = client?.auth.currentSession;

    if (client != null && session != null) {
      final response = await _dio.post<Map<String, dynamic>>(
        '${Env.supabaseUrl}/functions/v1/check-writing',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${session.accessToken}',
            'Content-Type': 'application/json',
          },
        ),
        data: {'text': text},
      );
      final result = FeedbackResult.fromJson(response.data!, original: text);
      await client.from('ai_feedback_history').insert({
        'user_id': session.user.id,
        'original_text': text,
        'feedback_json': result.toJson(),
      });
      await client.rpc('update_streak', params: {'p_user_id': session.user.id});
      return result;
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
