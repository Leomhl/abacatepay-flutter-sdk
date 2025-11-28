import 'package:abacatepay_flutter/src/client/interceptors.dart';
import 'package:abacatepay_flutter/src/core/constants.dart';
import 'package:abacatepay_flutter/src/exception/abacatepay_exception.dart';
import 'package:dio/dio.dart';

/// HTTP client for AbacatePay API requests.
class AbacatePayHttpClient {
  /// Creates an [AbacatePayHttpClient].
  AbacatePayHttpClient({
    required String apiKey,
    String? baseUrl,
    Duration? timeout,
    bool enableLogging = false,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = baseUrl ?? kBaseUrl;
    _dio.options.connectTimeout = timeout ?? kDefaultTimeout;
    _dio.options.receiveTimeout = timeout ?? kDefaultTimeout;

    _dio.interceptors.add(AuthInterceptor(apiKey: apiKey));

    if (enableLogging) {
      _dio.interceptors.add(const LoggingInterceptor());
    }
  }

  final Dio _dio;

  /// The underlying Dio instance for testing purposes.
  Dio get dio => _dio;

  /// Performs a GET request.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Performs a POST request.
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  AbacatePayException _handleDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data as Map<String, dynamic>?;
    final message = data?['error'] as String? ?? e.message ?? 'Unknown error';

    switch (statusCode) {
      case 400:
        return AbacatePayValidationException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 401:
        return AbacatePayAuthException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 404:
        return AbacatePayNotFoundException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
      case 429:
        final retryAfterHeader = e.response?.headers.value('Retry-After');
        final retryAfter = retryAfterHeader != null
            ? Duration(seconds: int.tryParse(retryAfterHeader) ?? 60)
            : null;
        return AbacatePayRateLimitException(
          message: message,
          statusCode: statusCode,
          data: data,
          retryAfter: retryAfter,
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return AbacatePayServerException(
            message: message,
            statusCode: statusCode,
            data: data,
          );
        }
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) {
          return AbacatePayNetworkException(message: message);
        }
        return AbacatePayException(
          message: message,
          statusCode: statusCode,
          data: data,
        );
    }
  }
}
