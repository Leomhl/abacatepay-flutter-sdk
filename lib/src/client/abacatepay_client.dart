import 'package:abacatepay_flutter/src/billing/billing_client.dart';
import 'package:abacatepay_flutter/src/client/http_client.dart';
import 'package:abacatepay_flutter/src/coupon/coupon_client.dart';
import 'package:abacatepay_flutter/src/customer/customer_client.dart';
import 'package:abacatepay_flutter/src/pix_qr_code/pix_qr_code_client.dart';
import 'package:abacatepay_flutter/src/store/store_client.dart';
import 'package:abacatepay_flutter/src/withdrawal/withdrawal_client.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

/// Options for configuring the AbacatePay client.
@immutable
class AbacatePayOptions {
  /// Creates [AbacatePayOptions].
  const AbacatePayOptions({
    this.baseUrl,
    this.timeout,
    this.enableLogging = false,
  });

  /// Custom base URL for the API.
  final String? baseUrl;

  /// Timeout for API requests.
  final Duration? timeout;

  /// Whether to enable request/response logging.
  final bool enableLogging;
}

/// Main client for the AbacatePay API.
///
/// Example:
/// ```dart
/// final abacatePay = AbacatePay(apiKey: 'your_api_key');
///
/// // Create a billing
/// final billing = await abacatePay.billing.create(
///   CreateBillingRequest(
///     frequency: BillingKind.oneTime,
///     methods: [BillingMethod.pix],
///     products: [
///       Product(
///         externalId: 'prod_001',
///         name: 'Product Name',
///         quantity: 1,
///         price: 1000,
///       ),
///     ],
///   ),
/// );
/// ```
class AbacatePay {
  /// Creates an [AbacatePay] client.
  ///
  /// [apiKey] is required and should be your AbacatePay API key.
  /// [options] allows customizing the client behavior.
  /// [dio] allows injecting a custom Dio instance for testing.
  AbacatePay({
    required String apiKey,
    AbacatePayOptions options = const AbacatePayOptions(),
    Dio? dio,
  }) : _httpClient = AbacatePayHttpClient(
          apiKey: apiKey,
          baseUrl: options.baseUrl,
          timeout: options.timeout,
          enableLogging: options.enableLogging,
          dio: dio,
        ) {
    _billing = BillingClient(httpClient: _httpClient);
    _customer = CustomerClient(httpClient: _httpClient);
    _coupon = CouponClient(httpClient: _httpClient);
    _pixQrCode = PixQrCodeClient(httpClient: _httpClient);
    _withdrawal = WithdrawalClient(httpClient: _httpClient);
    _store = StoreClient(httpClient: _httpClient);
  }

  final AbacatePayHttpClient _httpClient;

  late final BillingClient _billing;
  late final CustomerClient _customer;
  late final CouponClient _coupon;
  late final PixQrCodeClient _pixQrCode;
  late final WithdrawalClient _withdrawal;
  late final StoreClient _store;

  /// Client for billing operations.
  BillingClient get billing => _billing;

  /// Client for customer operations.
  CustomerClient get customer => _customer;

  /// Client for coupon operations.
  CouponClient get coupon => _coupon;

  /// Client for PIX QR Code operations.
  PixQrCodeClient get pixQrCode => _pixQrCode;

  /// Client for withdrawal operations.
  WithdrawalClient get withdrawal => _withdrawal;

  /// Client for store operations.
  StoreClient get store => _store;
}
