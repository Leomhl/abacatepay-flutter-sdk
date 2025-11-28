// ignore_for_file: unused_local_variable, avoid_print

import 'package:abacatepay_flutter/abacatepay_flutter.dart';

void main() async {
  // Initialize the client
  final abacatePay = AbacatePay(
    apiKey: 'your_api_key',
    options: const AbacatePayOptions(
      enableLogging: true,
    ),
  );

  // Example 1: Create a billing
  await createBillingExample(abacatePay);

  // Example 2: Create a PIX QR Code
  await createPixQrCodeExample(abacatePay);

  // Example 3: Manage customers
  await customerExample(abacatePay);

  // Example 4: Create a coupon
  await couponExample(abacatePay);

  // Example 5: Create a withdrawal
  await withdrawalExample(abacatePay);

  // Example 6: Get store info
  await storeExample(abacatePay);

  // Example 7: Handle errors
  await errorHandlingExample(abacatePay);
}

Future<void> createBillingExample(AbacatePay abacatePay) async {
  print('--- Creating a Billing ---');

  final billing = await abacatePay.billing.create(
    const CreateBillingRequest(
      frequency: BillingKind.oneTime,
      methods: [BillingMethod.pix],
      products: [
        Product(
          externalId: 'prod_001',
          name: 'Premium Plan',
          quantity: 1,
          price: 9900, // R$ 99.00 in cents
          description: 'Monthly subscription',
        ),
      ],
      returnUrl: 'https://yoursite.com/return',
      completionUrl: 'https://yoursite.com/success',
      customer: CustomerMetadata(
        email: 'customer@email.com',
        name: 'John Doe',
        cellphone: '+5511999999999',
        taxId: '12345678900',
      ),
    ),
  );

  print('Billing created: ${billing.id}');
  print('Payment URL: ${billing.url}');
  print('Amount: R\$ ${billing.amount / 100}');
  print('Status: ${billing.status}');

  // List all billings
  final billings = await abacatePay.billing.list();
  print('Total billings: ${billings.length}');
}

Future<void> createPixQrCodeExample(AbacatePay abacatePay) async {
  print('\n--- Creating a PIX QR Code ---');

  final pix = await abacatePay.pixQrCode.create(
    const CreatePixQrCodeRequest(
      amount: 5000, // R$ 50.00
      description: 'Order #123',
      expiresIn: Duration(minutes: 30),
    ),
  );

  print('PIX created: ${pix.id}');
  print('Copy and Paste code: ${pix.brCode}');
  print('Status: ${pix.status}');

  // Check status
  final status = await abacatePay.pixQrCode.check(id: pix.id);
  print('Current status: ${status.status}');

  // Simulate payment (dev mode only)
  // final paid = await abacatePay.pixQrCode.simulatePayment(id: pix.id);
  // print('Simulated payment status: ${paid.status}');
}

Future<void> customerExample(AbacatePay abacatePay) async {
  print('\n--- Managing Customers ---');

  // Create a customer
  final customer = await abacatePay.customer.create(
    const CreateCustomerRequest(
      email: 'maria@email.com',
      name: 'Maria Santos',
      cellphone: '+5511988888888',
      taxId: '98765432100',
    ),
  );

  print('Customer created: ${customer.id}');
  print('Email: ${customer.metadata.email}');

  // List all customers
  final customers = await abacatePay.customer.list();
  print('Total customers: ${customers.length}');
}

Future<void> couponExample(AbacatePay abacatePay) async {
  print('\n--- Creating a Coupon ---');

  final coupon = await abacatePay.coupon.create(
    const CreateCouponRequest(
      code: 'SAVE20',
      discountKind: DiscountKind.percentage,
      discount: 20, // 20%
      maxRedeems: 100,
      notes: 'Black Friday promotion',
    ),
  );

  print('Coupon created: ${coupon.id}');
  print('Code: ${coupon.code}');
  print('Discount: ${coupon.discount}%');
  print('Status: ${coupon.status}');

  // List all coupons
  final coupons = await abacatePay.coupon.list();
  print('Total coupons: ${coupons.length}');
}

Future<void> withdrawalExample(AbacatePay abacatePay) async {
  print('\n--- Creating a Withdrawal ---');

  final withdrawal = await abacatePay.withdrawal.create(
    const CreateWithdrawalRequest(
      amount: 10000, // R$ 100.00
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

  print('Withdrawal created: ${withdrawal.id}');
  print('Amount: R\$ ${withdrawal.amount / 100}');
  print('Status: ${withdrawal.status}');

  // Get withdrawal by ID
  final w = await abacatePay.withdrawal.get(id: withdrawal.id);
  print('Retrieved withdrawal status: ${w.status}');

  // List all withdrawals
  final withdrawals = await abacatePay.withdrawal.list();
  print('Total withdrawals: ${withdrawals.length}');
}

Future<void> storeExample(AbacatePay abacatePay) async {
  print('\n--- Getting Store Info ---');

  final store = await abacatePay.store.get();

  print('Store ID: ${store.id}');
  print('Name: ${store.name}');
  print('Email: ${store.email}');
  print('Dev Mode: ${store.devMode}');
}

Future<void> errorHandlingExample(AbacatePay abacatePay) async {
  print('\n--- Error Handling Example ---');

  try {
    // This will fail with invalid data
    await abacatePay.billing.create(
      const CreateBillingRequest(
        frequency: BillingKind.oneTime,
        methods: [BillingMethod.pix],
        products: [], // Empty products will cause validation error
      ),
    );
  } on AbacatePayAuthException catch (e) {
    print('Authentication error: ${e.message}');
  } on AbacatePayValidationException catch (e) {
    print('Validation error: ${e.message}');
  } on AbacatePayNotFoundException catch (e) {
    print('Not found: ${e.message}');
  } on AbacatePayRateLimitException catch (e) {
    print('Rate limited. Retry after: ${e.retryAfter}');
  } on AbacatePayServerException catch (e) {
    print('Server error: ${e.message}');
  } on AbacatePayNetworkException catch (e) {
    print('Network error: ${e.message}');
  } on AbacatePayException catch (e) {
    print('API error: ${e.message}');
  }
}

// Example of webhook validation
void webhookExample(String rawBody, Map<String, String> headers) {
  print('\n--- Webhook Validation Example ---');

  final isValid = AbacatePayWebhook.validateSignature(
    payload: rawBody,
    signature: headers['X-Webhook-Signature'],
    secret: 'your_webhook_secret',
  );

  if (!isValid) {
    print('Invalid webhook signature!');
    return;
  }

  final event = AbacatePayWebhook.parse(rawBody);

  print('Event ID: ${event.id}');
  print('Event Type: ${event.event}');
  print('Dev Mode: ${event.devMode}');

  switch (event.event) {
    case WebhookEventType.billingPaid:
      final billing = event.getBilling();
      if (billing != null) {
        print('Payment received for billing: ${billing.id}');
        print('Amount: R\$ ${billing.amount / 100}');
      }
    case WebhookEventType.withdrawDone:
      final withdrawal = event.getWithdrawal();
      if (withdrawal != null) {
        print('Withdrawal completed: ${withdrawal.id}');
      }
    case WebhookEventType.withdrawFailed:
      final withdrawal = event.getWithdrawal();
      if (withdrawal != null) {
        print('Withdrawal failed: ${withdrawal.id}');
      }
  }
}
