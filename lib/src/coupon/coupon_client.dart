import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/coupon/coupon_models.dart';

/// Client for coupon operations.
class CouponClient {
  /// Creates a [CouponClient].
  const CouponClient({required this.httpClient});

  /// The HTTP client.
  final AbacatePayHttpClient httpClient;

  /// Creates a new coupon.
  Future<Coupon> create(CreateCouponRequest request) async {
    final response = await httpClient.post(
      '/coupon/create',
      data: request.toJson(),
    );
    final data = response['data'] as Map<String, dynamic>;
    return Coupon.fromJson(data);
  }

  /// Lists all coupons.
  Future<List<Coupon>> list() async {
    final response = await httpClient.get('/coupon/list');
    final data = response['data'] as List<dynamic>;
    return data.map((e) => Coupon.fromJson(e as Map<String, dynamic>)).toList();
  }
}
