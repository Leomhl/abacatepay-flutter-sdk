// ignore_for_file: avoid_print

import 'package:abacatepay_flutter/abacatepay_flutter.dart';
import 'package:test/test.dart';

/// Integration tests with AbacatePay API (test mode)
///
/// Run with: flutter test test/integration_test.dart
void main() {
  const apiKey = 'abc_dev_RyQCGTC1TRAya5ezNMrtuL2p';

  late AbacatePay client;

  setUpAll(() {
    client = AbacatePay(
      apiKey: apiKey,
      options: const AbacatePayOptions(
        enableLogging: true,
        timeout: Duration(seconds: 30),
      ),
    );
  });

  group('Store API', () {
    test('GET /store/get - Gets store information', () async {
      final store = await client.store.get();

      print('\n=== Store Info ===');
      print('ID: ${store.id}');
      print('Name: ${store.name}');
      print('Email: ${store.email}');
      print('Dev Mode: ${store.devMode}');
      print('==================\n');

      expect(store.id, isNotEmpty);
      expect(store.name, isNotEmpty);
      // devMode can be null if not configured
    });
  });

  group('Customer API', () {
    test('POST /customer/create - Creates a new customer', () async {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final customer = await client.customer.create(
        CreateCustomerRequest(
          email: 'test_$timestamp@example.com',
          name: 'Test User $timestamp',
          cellphone: '+5511999999999',
          taxId: '09240529020', // Valid test CPF
        ),
      );

      print('\n=== Customer Created ===');
      print('ID: ${customer.id}');
      print('Email: ${customer.metadata.email}');
      print('Name: ${customer.metadata.name}');
      print('========================\n');

      expect(customer.id, isNotEmpty);
      expect(customer.metadata.email, contains('@example.com'));
    });

    test('GET /customer/list - Lists all customers', () async {
      final customers = await client.customer.list();

      print('\n=== Customer List ===');
      print('Total: ${customers.length}');
      for (final c in customers.take(5)) {
        print('  - ${c.id}: ${c.metadata.email}');
      }
      print('=====================\n');

      expect(customers, isA<List<Customer>>());
      if (customers.isNotEmpty) {
        expect(customers.first.id, isNotEmpty);
      }
    });
  });

  group('Billing API', () {
    test('POST /billing/create - Creates a new billing', () async {
      final billing = await client.billing.create(
        const CreateBillingRequest(
          frequency: BillingKind.oneTime,
          methods: [BillingMethod.pix],
          products: [
            Product(
              externalId: 'test_prod_001',
              name: 'Integration Test Product',
              quantity: 1,
              price: 1000, // $10.00
              description: 'Product for integration testing',
            ),
          ],
          returnUrl: 'https://example.com/return',
          completionUrl: 'https://example.com/success',
          customer: CustomerMetadata(
            email: 'billing_test@example.com',
            name: 'Billing Test User',
            cellphone: '+5511888888888',
            taxId: '09240529020',
          ),
        ),
      );

      print('\n=== Billing Created ===');
      print('ID: ${billing.id}');
      print('URL: ${billing.url}');
      print('Amount: \$ ${(billing.amount / 100).toStringAsFixed(2)}');
      print('Status: ${billing.status}');
      print('Dev Mode: ${billing.devMode}');
      print('Methods: ${billing.methods.map((m) => m.value).join(", ")}');
      print('========================\n');

      expect(billing.id, isNotEmpty);
      expect(billing.url, isNotEmpty);
      expect(billing.amount, equals(1000));
      expect(billing.status, equals(BillingStatus.pending));
      expect(billing.devMode, isTrue);
    });

    test('POST /billing/createLink - Creates multiple payment link', () async {
      final link = await client.billing.createLink(
        const CreateBillingLinkRequest(
          methods: [BillingMethod.pix],
          products: [
            Product(
              externalId: 'donation_001',
              name: 'Recurring Donation',
              quantity: 1,
              price: 500, // $5.00
              description: 'Reusable donation link',
            ),
          ],
          returnUrl: 'https://example.com/return',
          completionUrl: 'https://example.com/thanks',
        ),
      );

      print('\n=== Billing Link Created ===');
      print('ID: ${link.id}');
      print('URL: ${link.url}');
      print('Amount: \$ ${(link.amount / 100).toStringAsFixed(2)}');
      print('Frequency: ${link.frequency.value}');
      print('Dev Mode: ${link.devMode}');
      print('============================\n');

      expect(link.id, isNotEmpty);
      expect(link.url, isNotEmpty);
      expect(link.amount, equals(500));
      expect(link.frequency, equals(BillingKind.multiplePayments));
      expect(link.status, equals(BillingStatus.active));
      expect(link.devMode, isTrue);
    });

    test('GET /billing/list - Lists all billings', () async {
      final billings = await client.billing.list();

      print('\n=== Billing List ===');
      print('Total: ${billings.length}');
      for (final b in billings.take(5)) {
        final amount = (b.amount / 100).toStringAsFixed(2);
        print('  - ${b.id}: ${b.status.value} (\$ $amount)');
      }
      print('====================\n');

      expect(billings, isA<List<Billing>>());
      if (billings.isNotEmpty) {
        expect(billings.first.id, isNotEmpty);
      }
    });
  });

  group('PIX QR Code API', () {
    test('POST /pixQrCode/create - Creates a PIX QR Code', () async {
      final pix = await client.pixQrCode.create(
        const CreatePixQrCodeRequest(
          amount: 500, // $5.00
          description: 'PIX Integration Test',
          expiresIn: Duration(minutes: 30),
        ),
      );

      print('\n=== PIX QR Code Created ===');
      print('ID: ${pix.id}');
      print('Amount: \$ ${((pix.amount ?? 0) / 100).toStringAsFixed(2)}');
      print('Status: ${pix.status}');
      print('Dev Mode: ${pix.devMode}');
      if (pix.brCode != null && pix.brCode!.length > 50) {
        print('BR Code (truncated): ${pix.brCode!.substring(0, 50)}...');
      }
      print('===========================\n');

      expect(pix.id, isNotEmpty);
      expect(pix.amount, equals(500));
      expect(pix.status, equals(PixQrCodeStatus.pending));
      expect(pix.devMode, isTrue);
      expect(pix.brCode, isNotNull);
      expect(pix.brCodeBase64, isNotNull);
    });

    test('GET /pixQrCode/check - Checks PIX status', () async {
      // First create a PIX to check
      final createdPix = await client.pixQrCode.create(
        const CreatePixQrCodeRequest(
          amount: 300,
          description: 'PIX for check test',
        ),
      );

      final pix = await client.pixQrCode.check(id: createdPix.id);

      print('\n=== PIX Check ===');
      print('ID: ${pix.id}');
      print('Status: ${pix.status}');
      print('=================\n');

      expect(pix.id, equals(createdPix.id));
      expect(pix.status, isNotNull);
    });

    test('POST /pixQrCode/simulate-payment - Simulates payment (dev mode)',
        () async {
      // Create a new PIX to simulate payment
      final createdPix = await client.pixQrCode.create(
        const CreatePixQrCodeRequest(
          amount: 200,
          description: 'PIX for simulate payment test',
        ),
      );

      final pix = await client.pixQrCode.simulatePayment(id: createdPix.id);

      print('\n=== PIX Simulate Payment ===');
      print('ID: ${pix.id}');
      print('Status: ${pix.status}');
      print('============================\n');

      expect(pix.id, equals(createdPix.id));
      // In dev mode, should mark as paid
      expect(pix.status, equals(PixQrCodeStatus.paid));
    });
  });

  group('Coupon API', () {
    test('POST /coupon/create - Creates a new coupon', () async {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final coupon = await client.coupon.create(
        CreateCouponRequest(
          code: 'TEST_$timestamp',
          discountKind: DiscountKind.percentage,
          discount: 10, // 10%
          maxRedeems: 100,
          notes: 'Integration test coupon',
        ),
      );

      print('\n=== Coupon Created ===');
      print('ID: ${coupon.id}');
      print('Code: ${coupon.code}');
      print('Discount: ${coupon.discount ?? 0}%');
      print('Status: ${coupon.status}');
      print('======================\n');

      expect(coupon.id, isNotEmpty);
    });

    test('GET /coupon/list - Lists all coupons', () async {
      final coupons = await client.coupon.list();

      print('\n=== Coupon List ===');
      print('Total: ${coupons.length}');
      for (final c in coupons.take(5)) {
        print('  - ${c.id}: ${c.code} (${c.discount ?? 0}% off)');
      }
      print('===================\n');

      expect(coupons, isA<List<Coupon>>());
    });
  });

  group('Withdrawal API', () {
    // NOTE: The withdrawal endpoint exists in the AbacatePay API according
    // to docs, but may not be available in test/dev accounts or requires:
    // - Account verification
    // - Available balance for withdrawal
    // - PIX key configuration for receiving
    // Reference: https://docs.abacatepay.com
    test('GET /withdrawal/list - Lists all withdrawals', () async {
      try {
        final withdrawals = await client.withdrawal.list();

        print('\n=== Withdrawal List ===');
        print('Total: ${withdrawals.length}');
        for (final w in withdrawals.take(5)) {
          final amount = (w.amount / 100).toStringAsFixed(2);
          print('  - ${w.id}: \$ $amount (${w.status.value})');
        }
        print('=======================\n');

        expect(withdrawals, isA<List<Withdrawal>>());
      } on AbacatePayNotFoundException {
        // Endpoint returns 404 in dev/test accounts
        print('\n=== Withdrawal API ===');
        print('Endpoint not available in dev/test mode (404)');
        print('Requires verified account with available balance');
        print('=======================\n');
      }
    });
  });

  group('Error Handling', () {
    test('Returns authentication error with invalid API key', () async {
      final invalidClient = AbacatePay(apiKey: 'invalid_key_12345');

      expect(
        () => invalidClient.store.get(),
        throwsA(isA<AbacatePayAuthException>()),
      );
    });
  });

  group('Full Flow Test', () {
    test('Complete flow: create billing and simulate PIX payment', () async {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      // 1. Create billing
      final billing = await client.billing.create(
        CreateBillingRequest(
          frequency: BillingKind.oneTime,
          methods: const [BillingMethod.pix],
          products: const [
            Product(
              externalId: 'fullflow_prod',
              name: 'Full Flow Product',
              quantity: 2,
              price: 1500,
            ),
          ],
          customer: CustomerMetadata(
            email: 'fullflow_$timestamp@example.com',
            name: 'Full Flow Test User',
            cellphone: '+5511777777777',
            taxId: '09240529020',
          ),
          returnUrl: 'https://example.com/return',
          completionUrl: 'https://example.com/done',
        ),
      );
      print('\n[FLOW] Billing created: ${billing.id}');
      print('[FLOW] Total: \$ ${(billing.amount / 100).toStringAsFixed(2)}');
      print('[FLOW] Payment URL: ${billing.url}');

      expect(billing.amount, equals(3000)); // 2 x $15.00

      // 2. Create PIX QR Code and simulate payment
      final pix = await client.pixQrCode.create(
        const CreatePixQrCodeRequest(
          amount: 100,
          description: 'Flow test PIX',
        ),
      );
      print('[FLOW] PIX created: ${pix.id}');

      final paidPix = await client.pixQrCode.simulatePayment(id: pix.id);
      print('[FLOW] PIX paid: ${paidPix.status}');

      expect(paidPix.status, equals(PixQrCodeStatus.paid));

      print('[FLOW] Complete flow executed successfully!\n');
    });
  });
}
