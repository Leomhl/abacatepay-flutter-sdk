import 'package:meta/meta.dart';

/// Generic API response wrapper.
@immutable
class ApiResponse<T> {
  /// Creates an [ApiResponse].
  const ApiResponse({
    required this.data,
    this.error,
  });

  /// Response data.
  final T data;

  /// Error message, if any.
  final String? error;

  /// Whether the response has an error.
  bool get hasError => error != null;

  /// Whether the response is successful.
  bool get isSuccess => !hasError;
}

/// API list response wrapper.
@immutable
class ApiListResponse<T> {
  /// Creates an [ApiListResponse].
  const ApiListResponse({
    required this.data,
    this.error,
  });

  /// Response data.
  final List<T> data;

  /// Error message, if any.
  final String? error;

  /// Whether the response has an error.
  bool get hasError => error != null;

  /// Whether the response is successful.
  bool get isSuccess => !hasError;
}
