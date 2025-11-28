import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/customer/customer_models.dart';

/// Client for customer operations.
class CustomerClient {
  /// Creates a [CustomerClient].
  const CustomerClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Creates a new customer.
  Future<Customer> create(CreateCustomerRequest request) async {
    final response = await httpClient.post(
      '/customer/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return Customer.fromJson(data);
  }

  /// Lists all customers.
  Future<List<Customer>> list() async {
    final response = await httpClient.get('/customer/list');
    final data = response['data'] as List<dynamic>;
    return data
        .map((e) => Customer.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
