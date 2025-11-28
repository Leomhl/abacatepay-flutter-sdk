/// AbacatePay Flutter SDK
///
/// Official Flutter SDK for AbacatePay API integration.
///
/// Usage example:
/// ```dart
/// import 'package:abacatepay_flutter/abacatepay_flutter.dart';
///
/// void main() async {
///   final abacatePay = AbacatePay(apiKey: 'your_api_key');
///
///   // Create a billing
///   final billing = await abacatePay.billing.create(
///     CreateBillingRequest(
///       frequency: BillingKind.oneTime,
///       methods: [BillingMethod.pix],
///       products: [
///         Product(
///           externalId: 'prod_001',
///           name: 'Example Product',
///           quantity: 1,
///           price: 1000,
///         ),
///       ],
///     ),
///   );
///
///   print('Payment URL: ${billing.url}');
/// }
/// ```
library abacatepay_flutter;

// Billing
export 'src/billing/billing_client.dart';
export 'src/billing/billing_models.dart';
// Client
export 'src/client/abacatepay_client.dart';
// Coupon
export 'src/coupon/coupon_client.dart';
export 'src/coupon/coupon_models.dart';
// Customer
export 'src/customer/customer_client.dart';
export 'src/customer/customer_models.dart';
// Exceptions
export 'src/exception/abacatepay_exception.dart';
// PIX QR Code
export 'src/pix_qr_code/pix_qr_code_client.dart';
export 'src/pix_qr_code/pix_qr_code_models.dart';
// Product
export 'src/product/product_models.dart';
// Store
export 'src/store/store_client.dart';
export 'src/store/store_models.dart';
// Webhook
export 'src/webhook/webhook_models.dart';
export 'src/webhook/webhook_validator.dart';
// Withdrawal
export 'src/withdrawal/withdrawal_client.dart';
export 'src/withdrawal/withdrawal_models.dart';
