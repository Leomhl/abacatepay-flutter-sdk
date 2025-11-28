/// Base exception for all AbacatePay errors.
class AbacatePayException implements Exception {
  /// Creates an [AbacatePayException].
  const AbacatePayException({
    required this.message,
    this.statusCode,
    this.data,
  });

  /// Error message.
  final String message;

  /// HTTP status code, if applicable.
  final int? statusCode;

  /// Additional error data from the API.
  final Map<String, dynamic>? data;

  @override
  String toString() => 'AbacatePayException: $message';
}

/// Exception thrown when authentication fails (401).
class AbacatePayAuthException extends AbacatePayException {
  /// Creates an [AbacatePayAuthException].
  const AbacatePayAuthException({
    super.message = 'Invalid or missing API key',
    super.statusCode = 401,
    super.data,
  });

  @override
  String toString() => 'AbacatePayAuthException: $message';
}

/// Exception thrown when validation fails (400).
class AbacatePayValidationException extends AbacatePayException {
  /// Creates an [AbacatePayValidationException].
  const AbacatePayValidationException({
    required super.message,
    super.statusCode = 400,
    super.data,
    this.errors,
  });

  /// Validation errors by field.
  final Map<String, List<String>>? errors;

  @override
  String toString() => 'AbacatePayValidationException: $message';
}

/// Exception thrown when a resource is not found (404).
class AbacatePayNotFoundException extends AbacatePayException {
  /// Creates an [AbacatePayNotFoundException].
  const AbacatePayNotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
    super.data,
  });

  @override
  String toString() => 'AbacatePayNotFoundException: $message';
}

/// Exception thrown when rate limit is exceeded (429).
class AbacatePayRateLimitException extends AbacatePayException {
  /// Creates an [AbacatePayRateLimitException].
  const AbacatePayRateLimitException({
    super.message = 'Rate limit exceeded',
    super.statusCode = 429,
    super.data,
    this.retryAfter,
  });

  /// Time to wait before retrying.
  final Duration? retryAfter;

  @override
  String toString() => 'AbacatePayRateLimitException: $message';
}

/// Exception thrown when a server error occurs (5xx).
class AbacatePayServerException extends AbacatePayException {
  /// Creates an [AbacatePayServerException].
  const AbacatePayServerException({
    super.message = 'Internal server error',
    super.statusCode = 500,
    super.data,
  });

  @override
  String toString() => 'AbacatePayServerException: $message';
}

/// Exception thrown when a network error occurs.
class AbacatePayNetworkException extends AbacatePayException {
  /// Creates an [AbacatePayNetworkException].
  const AbacatePayNetworkException({
    super.message = 'Network error',
    super.data,
  });

  @override
  String toString() => 'AbacatePayNetworkException: $message';
}
