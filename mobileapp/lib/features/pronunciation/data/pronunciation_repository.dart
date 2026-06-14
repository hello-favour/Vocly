import 'dart:io';

import 'package:dio/dio.dart';
import 'package:record/record.dart';

import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/network/api_client.dart';
import '../models/pronunciation_result.dart';

class PronunciationRepository {
  PronunciationRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  final ApiClient _apiClient;
  final AudioRecorder _recorder = AudioRecorder();

  Future<void> startRecording() async {
    if (!_apiClient.isConfigured || !_apiClient.hasAuthToken) {
      throw const NetworkException(
        'Sign in and connect Vocly to Supabase before recording.',
      );
    }
    if (!await _recorder.hasPermission()) {
      throw const NetworkException(
        'Microphone permission is required for speaking practice.',
      );
    }

    final path =
        '${Directory.systemTemp.path}/vocly-${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
  }

  Future<PronunciationResult> stopAndScore(String phrase) async {
    final path = await _recorder.stop();
    if (path == null || !File(path).existsSync()) {
      throw const NetworkException('No recording was captured. Try again.');
    }

    try {
      final payload = await _apiClient.postFormData(
        '/score-pronunciation',
        data: FormData.fromMap({
          'word': phrase,
          'audio': await MultipartFile.fromFile(
            path,
            filename: 'vocly-practice.m4a',
          ),
        }),
      );
      return PronunciationResult(
        word: phrase,
        scoreOverall: _scoreFrom(payload).round().clamp(0, 100),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 429) {
        throw const FreeLimitReachedException('pronunciation');
      }
      throw NetworkException(
        error.response?.data is Map
            ? ((error.response?.data as Map)['error']?.toString() ??
                  'Pronunciation scoring failed.')
            : (error.message ?? 'Pronunciation scoring failed.'),
      );
    } finally {
      await File(path).delete().catchError((_) => File(path));
    }
  }

  Future<void> cancelRecording() => _recorder.cancel();

  Future<void> dispose() => _recorder.dispose();
}

num _scoreFrom(Map<String, dynamic> payload) {
  final textScore = payload['text_score'];
  if (textScore is Map) {
    final speechaceScore = textScore['speechace_score'];
    if (speechaceScore is Map && speechaceScore['pronunciation'] is num) {
      return speechaceScore['pronunciation'] as num;
    }
  }
  return payload['score_overall'] as num? ??
      payload['overall_score'] as num? ??
      0;
}
