import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/pix_qr_code/pix_qr_code_models.dart';

/// Client for PIX QR Code operations.
class PixQrCodeClient {
  /// Creates a [PixQrCodeClient].
  const PixQrCodeClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Creates a new PIX QR Code.
  Future<PixQrCode> create(CreatePixQrCodeRequest request) async {
    final response = await httpClient.post(
      '/pixQrCode/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return PixQrCode.fromJson(data);
  }

  /// Checks the status of a PIX QR Code.
  Future<PixQrCode> check({required String id}) async {
    final response = await httpClient.get(
      '/pixQrCode/check',
      queryParameters: {'id': id},
    );
    final data = response['data'] as Map<String, dynamic>;
    return PixQrCode.fromJson(data);
  }

  /// Simulates a payment for a PIX QR Code (dev mode only).
  Future<PixQrCode> simulatePayment({required String id}) async {
    final response = await httpClient.post(
      '/pixQrCode/simulate-payment',
      queryParameters: {'id': id},
      data: {},
    );
    final data = response['data'] as Map<String, dynamic>;
    return PixQrCode.fromJson(data);
  }
}
