import 'package:abacatepay_flutter/src/billing/billing_models.dart';
import 'package:abacatepay_flutter/src/client/http_client.dart';

/// Client for billing operations.
class BillingClient {
  /// Creates a [BillingClient].
  const BillingClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Creates a new billing.
  Future<Billing> create(CreateBillingRequest request) async {
    final response = await httpClient.post(
      '/billing/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return Billing.fromJson(data);
  }

  /// Creates a billing link that allows multiple payments.
  ///
  /// This is a convenience method that creates a billing with
  /// [BillingKind.multiplePayments] frequency, allowing the same
  /// payment link to be reused for multiple transactions.
  ///
  /// Example:
  /// ```dart
  /// final link = await client.billing.createLink(
  ///   CreateBillingLinkRequest(
  ///     methods: [BillingMethod.pix],
  ///     products: [
  ///       Product(
  ///         externalId: 'donation',
  ///         name: 'Donation',
  ///         quantity: 1,
  ///         price: 1000,
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// print('Reusable link: ${link.url}');
  /// ```
  Future<Billing> createLink(CreateBillingLinkRequest request) async {
    final response = await httpClient.post(
      '/billing/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return Billing.fromJson(data);
  }

  /// Lists all billings.
  Future<List<Billing>> list() async {
    final response = await httpClient.get('/billing/list');
    final data = response['data'] as List<dynamic>;
    return data
        .map((e) => Billing.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
