import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/store/store_models.dart';

/// Client for store operations.
class StoreClient {
  /// Creates a [StoreClient].
  const StoreClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Gets the store information.
  Future<Store> get() async {
    final response = await httpClient.get('/store/get');
    final data = response['data'] as Map<String, dynamic>;
    return Store.fromJson(data);
  }
}
