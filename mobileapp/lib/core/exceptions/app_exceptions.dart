class FreeLimitReachedException implements Exception {
  const FreeLimitReachedException(this.feature);

  final String feature;

  @override
  String toString() => 'Free limit reached for $feature';
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  const NetworkException(this.message);

  final String message;

  @override
  String toString() => message;
}

class SupabaseException implements Exception {
  const SupabaseException(this.message);

  final String message;

  @override
  String toString() => message;
}
