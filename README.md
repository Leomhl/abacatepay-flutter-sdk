<p align="center">
  <img src="assets/flubacate.png" alt="Flubacate" width="100%">
</p>

<h1 align="center">AbacatePay Flutter SDK</h1>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/flutter-3.16+-blue.svg" alt="Flutter">
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT">
  </a>
</p>

<p align="center">
  <strong>Official AbacatePay SDK - Accept payments in seconds with a simple integration.</strong>
</p>

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  abacatepay_flutter: ^0.0.1
```

Or install via command line:

```bash
flutter pub add abacatepay_flutter
```

---

## Quick Start

```dart
import 'package:abacatepay_flutter/abacatepay_flutter.dart';

final abacatePay = AbacatePay(apiKey: 'your_api_key');
```

---

## Usage

### Creating a Billing

```dart
final billing = await abacatePay.billing.create(
  CreateBillingRequest(
    frequency: BillingKind.oneTime,
    methods: [BillingMethod.pix],
    products: [
      Product(
        externalId: 'product_001',
        name: 'Premium Plan',
        quantity: 1,
        price: 9900, // R$ 99.00 in cents
      ),
    ],
    returnUrl: 'https://yoursite.com/return',
    completionUrl: 'https://yoursite.com/success',
    customer: CustomerMetadata(
      name: 'John Doe',
      email: 'john@example.com',
      cellphone: '+5511999999999',
      taxId: '12345678900',
    ),
  ),
);

print(billing.url); // https://abacatepay.com/pay/bill_xxxxx
```

### Response

```dart
Billing(
  id: 'bill_12345667',
  url: 'https://abacatepay.com/pay/bill_12345667',
  status: BillingStatus.pending,
  // ...
)
```

### Listing Billings

```dart
final billings = await abacatePay.billing.list();

for (final billing in billings) {
  print('${billing.id}: ${billing.status}');
}
```

---

## PIX QR Code

```dart
// Create a PIX QR Code
final pix = await abacatePay.pixQrCode.create(
  CreatePixQrCodeRequest(
    amount: 5000, // R$ 50.00 in cents
    description: 'Order #123',
  ),
);

print(pix.brCode);       // Copy and paste code
print(pix.brCodeBase64); // QR Code image in base64

// Check payment status
final status = await abacatePay.pixQrCode.check(id: pix.id);

// Simulate payment (dev mode only)
await abacatePay.pixQrCode.simulatePayment(id: pix.id);
```

---

## Customers

```dart
// Create a customer
final customer = await abacatePay.customer.create(
  CreateCustomerRequest(
    name: 'Maria Santos',
    email: 'maria@example.com',
    cellphone: '+5511999999999',
    taxId: '12345678900',
  ),
);

// List all customers
final customers = await abacatePay.customer.list();
```

---

## Coupons

```dart
// Create a discount coupon
final coupon = await abacatePay.coupon.create(
  CreateCouponRequest(
    code: 'SAVE10',
    discountKind: DiscountKind.percentage,
    discount: 10,
    maxRedeems: 100,
  ),
);

// List all coupons
final coupons = await abacatePay.coupon.list();
```

---

## Withdrawals

```dart
// Create a withdrawal
final withdrawal = await abacatePay.withdrawal.create(
  CreateWithdrawalRequest(
    amount: 10000, // R$ 100.00 in cents
    bankAccount: BankAccount(
      bankCode: '001',
      agency: '1234',
      account: '12345-6',
      accountType: AccountType.checking,
      holderName: 'John Doe',
      holderDocument: '12345678900',
    ),
  ),
);

// Get a withdrawal by ID
final w = await abacatePay.withdrawal.get(id: withdrawal.id);

// List all withdrawals
final withdrawals = await abacatePay.withdrawal.list();
```

---

## Store

```dart
final store = await abacatePay.store.get();
print(store.name);
```

---

## Webhooks

```dart
// Validate webhook signature
final isValid = AbacatePayWebhook.validateSignature(
  payload: rawBody,
  signature: headers['X-Webhook-Signature'],
  secret: 'your_webhook_secret',
);

if (isValid) {
  final event = AbacatePayWebhook.parse(rawBody);

  switch (event.event) {
    case WebhookEventType.billingPaid:
      final billing = event.getBilling();
      print('Payment received: ${billing?.id}');
      break;
    case WebhookEventType.withdrawDone:
      final withdrawal = event.getWithdrawal();
      print('Withdrawal completed: ${withdrawal?.id}');
      break;
    case WebhookEventType.withdrawFailed:
      print('Withdrawal failed');
      break;
  }
}
```

---

## Error Handling

```dart
try {
  final billing = await abacatePay.billing.create(...);
} on AbacatePayAuthException catch (e) {
  print('Invalid API key: ${e.message}');
} on AbacatePayValidationException catch (e) {
  print('Validation error: ${e.message}');
} on AbacatePayNotFoundException catch (e) {
  print('Not found: ${e.message}');
} on AbacatePayRateLimitException catch (e) {
  print('Rate limit exceeded. Retry after: ${e.retryAfter}');
} on AbacatePayException catch (e) {
  print('API error: ${e.message}');
}
```

---

## Configuration

```dart
final abacatePay = AbacatePay(
  apiKey: 'your_api_key',
  options: AbacatePayOptions(
    timeout: Duration(seconds: 60),
    enableLogging: true,
  ),
);
```

---

## Payment Methods

| Method | Status |
|--------|--------|
| PIX    | Available |

---

## Documentation

For complete API documentation, visit: **[docs.abacatepay.com](https://docs.abacatepay.com)**

---

## Support

- Open an [issue](https://github.com/AbacatePay/abacatepay-flutter-sdk/issues)
- Email: ajuda@abacatepay.com

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
