import 'package:abacatepay_flutter/src/core/constants.dart';
import 'package:dio/dio.dart';

/// Interceptor that adds authentication headers to requests.
class AuthInterceptor extends Interceptor {
  /// Creates an [AuthInterceptor].
  AuthInterceptor({required this.apiKey});

  /// The API key for authentication.
  final String apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $apiKey';
    options.headers['Content-Type'] = 'application/json';
    options.headers['User-Agent'] = getUserAgent();
    handler.next(options);
  }
}

/// Interceptor that logs requests and responses.
class LoggingInterceptor extends Interceptor {
  /// Creates a [LoggingInterceptor].
  const LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('[AbacatePay] ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // ignore: avoid_print
    print('[AbacatePay] Response: ${response.statusCode}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[AbacatePay] Error: ${err.message}');
    handler.next(err);
  }
}
