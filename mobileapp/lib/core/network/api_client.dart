import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/env.dart';

class ApiClient {
  ApiClient([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Env.apiBaseUrl,
              connectTimeout: const Duration(seconds: 12),
              receiveTimeout: const Duration(seconds: 20),
              headers: {
                'Content-Type': 'application/json',
                if (Env.backendAuthToken.isNotEmpty)
                  'Authorization': 'Bearer ${Env.backendAuthToken}',
              },
            ),
          );

  final Dio _dio;

  bool get isConfigured => Env.hasBackend;
  bool get hasAuthToken => Env.backendAuthToken.isNotEmpty;

  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
      options: Options(headers: _authHeaders()),
    );
    return response.data ?? <String, dynamic>{};
  }

  Future<Map<String, dynamic>> postJson(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: data,
      options: Options(headers: _authHeaders()),
    );
    return response.data ?? <String, dynamic>{};
  }

  Future<Map<String, dynamic>> postFormData(
    String path, {
    required FormData data,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: data,
      options: Options(
        headers: _authHeaders(),
        contentType: 'multipart/form-data',
      ),
    );
    return response.data ?? <String, dynamic>{};
  }

  Map<String, String> _authHeaders() {
    final token = _currentAccessToken();
    return {
      if (Env.supabaseClientKey.isNotEmpty) 'apikey': Env.supabaseClientKey,
      if (token != null) 'Authorization': 'Bearer $token',
      if (token == null && Env.backendAuthToken.isNotEmpty)
        'Authorization': 'Bearer ${Env.backendAuthToken}',
    };
  }

  String? _currentAccessToken() {
    if (!Env.hasSupabase) return null;
    try {
      return Supabase.instance.client.auth.currentSession?.accessToken;
    } catch (_) {
      return null;
    }
  }
}
