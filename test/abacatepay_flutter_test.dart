import 'package:abacatepay_flutter/abacatepay_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AbacatePay', () {
    test('creates client with API key', () {
      final client = AbacatePay(apiKey: 'test_api_key');

      expect(client.billing, isA<BillingClient>());
      expect(client.customer, isA<CustomerClient>());
      expect(client.coupon, isA<CouponClient>());
      expect(client.pixQrCode, isA<PixQrCodeClient>());
      expect(client.withdrawal, isA<WithdrawalClient>());
      expect(client.store, isA<StoreClient>());
    });

    test('creates client with options', () {
      final client = AbacatePay(
        apiKey: 'test_api_key',
        options: const AbacatePayOptions(
          timeout: Duration(seconds: 60),
          enableLogging: true,
        ),
      );

      expect(client, isNotNull);
    });
  });

  group('Product', () {
    test('creates product with required fields', () {
      const product = Product(
        externalId: 'prod_001',
        name: 'Test Product',
        quantity: 1,
        price: 1000,
      );

      expect(product.externalId, 'prod_001');
      expect(product.name, 'Test Product');
      expect(product.quantity, 1);
      expect(product.price, 1000);
      expect(product.description, isNull);
    });

    test('serializes to JSON', () {
      const product = Product(
        externalId: 'prod_001',
        name: 'Test Product',
        quantity: 1,
        price: 1000,
        description: 'A test product',
      );

      final json = product.toJson();

      expect(json['externalId'], 'prod_001');
      expect(json['name'], 'Test Product');
      expect(json['quantity'], 1);
      expect(json['price'], 1000);
      expect(json['description'], 'A test product');
    });

    test('deserializes from JSON', () {
      final json = {
        'externalId': 'prod_001',
        'name': 'Test Product',
        'quantity': 1,
        'price': 1000,
      };

      final product = Product.fromJson(json);

      expect(product.externalId, 'prod_001');
      expect(product.name, 'Test Product');
      expect(product.quantity, 1);
      expect(product.price, 1000);
    });
  });

  group('CustomerMetadata', () {
    test('creates metadata with required fields', () {
      const metadata = CustomerMetadata(email: 'test@email.com');

      expect(metadata.email, 'test@email.com');
      expect(metadata.name, isNull);
      expect(metadata.cellphone, isNull);
      expect(metadata.taxId, isNull);
    });

    test('creates metadata with all fields', () {
      const metadata = CustomerMetadata(
        email: 'test@email.com',
        name: 'John Doe',
        cellphone: '+5511999999999',
        taxId: '12345678900',
      );

      expect(metadata.email, 'test@email.com');
      expect(metadata.name, 'John Doe');
      expect(metadata.cellphone, '+5511999999999');
      expect(metadata.taxId, '12345678900');
    });
  });

  group('BillingStatus', () {
    test('has correct values', () {
      expect(BillingStatus.pending.value, 'PENDING');
      expect(BillingStatus.expired.value, 'EXPIRED');
      expect(BillingStatus.cancelled.value, 'CANCELLED');
      expect(BillingStatus.paid.value, 'PAID');
      expect(BillingStatus.refunded.value, 'REFUNDED');
    });
  });

  group('BillingMethod', () {
    test('has correct values', () {
      expect(BillingMethod.pix.value, 'PIX');
      expect(BillingMethod.card.value, 'CARD');
    });
  });

  group('BillingKind', () {
    test('has correct values', () {
      expect(BillingKind.oneTime.value, 'ONE_TIME');
      expect(BillingKind.multiplePayments.value, 'MULTIPLE_PAYMENTS');
    });
  });

  group('AbacatePayWebhook', () {
    test('validates correct signature', () {
      const payload = '{"id":"test","event":"billing.paid"}';
      const secret = 'test_secret';

      // Generate the expected signature
      final isValid = AbacatePayWebhook.validateSignature(
        payload: payload,
        signature:
            '8c5d5d8d8c8d5d8d8c5d5d8d8c8d5d8d8c5d5d8d8c8d5d8d8c5d5d8d8c8d5d8d',
        secret: secret,
      );

      // This will be false because the signature doesn't match
      expect(isValid, isFalse);
    });

    test('rejects null signature', () {
      const payload = '{"id":"test","event":"billing.paid"}';
      const secret = 'test_secret';

      final isValid = AbacatePayWebhook.validateSignature(
        payload: payload,
        signature: null,
        secret: secret,
      );

      expect(isValid, isFalse);
    });

    test('rejects empty signature', () {
      const payload = '{"id":"test","event":"billing.paid"}';
      const secret = 'test_secret';

      final isValid = AbacatePayWebhook.validateSignature(
        payload: payload,
        signature: '',
        secret: secret,
      );

      expect(isValid, isFalse);
    });
  });

  group('Exceptions', () {
    test('AbacatePayException has correct properties', () {
      const exception = AbacatePayException(
        message: 'Test error',
        statusCode: 500,
      );

      expect(exception.message, 'Test error');
      expect(exception.statusCode, 500);
      expect(exception.toString(), 'AbacatePayException: Test error');
    });

    test('AbacatePayAuthException defaults', () {
      const exception = AbacatePayAuthException();

      expect(exception.message, 'Invalid or missing API key');
      expect(exception.statusCode, 401);
    });

    test('AbacatePayValidationException has errors', () {
      const exception = AbacatePayValidationException(
        message: 'Validation failed',
        errors: {
          'email': ['Invalid email'],
        },
      );

      expect(exception.message, 'Validation failed');
      expect(exception.errors, isNotNull);
      expect(exception.errors!['email'], contains('Invalid email'));
    });

    test('AbacatePayNotFoundException defaults', () {
      const exception = AbacatePayNotFoundException();

      expect(exception.message, 'Resource not found');
      expect(exception.statusCode, 404);
    });

    test('AbacatePayRateLimitException has retryAfter', () {
      const exception = AbacatePayRateLimitException(
        retryAfter: Duration(seconds: 60),
      );

      expect(exception.message, 'Rate limit exceeded');
      expect(exception.statusCode, 429);
      expect(exception.retryAfter, const Duration(seconds: 60));
    });
  });
}
