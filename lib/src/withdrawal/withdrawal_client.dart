import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/withdrawal/withdrawal_models.dart';

/// Client for withdrawal operations.
class WithdrawalClient {
  /// Creates a [WithdrawalClient].
  const WithdrawalClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Creates a new withdrawal.
  Future<Withdrawal> create(CreateWithdrawalRequest request) async {
    final response = await httpClient.post(
      '/withdrawal/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return Withdrawal.fromJson(data);
  }

  /// Gets a withdrawal by ID.
  Future<Withdrawal> get({required String id}) async {
    final response = await httpClient.get(
      '/withdrawal/get',
      queryParameters: {'id': id},
    );
    final data = response['data'] as Map<String, dynamic>;
    return Withdrawal.fromJson(data);
  }

  /// Lists all withdrawals.
  Future<List<Withdrawal>> list() async {
    final response = await httpClient.get('/withdrawal/list');
    final data = response['data'] as List<dynamic>;
    return data
        .map((e) => Withdrawal.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
