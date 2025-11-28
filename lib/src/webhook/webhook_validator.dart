import 'dart:convert';

import 'package:abacatepay_flutter/src/webhook/webhook_models.dart';
import 'package:crypto/crypto.dart';

/// Utility class for validating and parsing webhooks.
class AbacatePayWebhook {
  AbacatePayWebhook._();

  /// Validates the webhook signature.
  ///
  /// [payload] is the raw request body as a string.
  /// [signature] is the value of the X-Webhook-Signature header.
  /// [secret] is your webhook secret.
  static bool validateSignature({
    required String payload,
    required String? signature,
    required String secret,
  }) {
    if (signature == null || signature.isEmpty) {
      return false;
    }

    final key = utf8.encode(secret);
    final bytes = utf8.encode(payload);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    final expectedSignature = digest.toString();

    return signature == expectedSignature;
  }

  /// Parses a webhook event from the raw payload.
  static WebhookEvent parse(String payload) {
    final json = jsonDecode(payload) as Map<String, dynamic>;
    return WebhookEvent.fromJson(json);
  }

  /// Parses a webhook event from a JSON map.
  static WebhookEvent parseJson(Map<String, dynamic> json) {
    return WebhookEvent.fromJson(json);
  }
}
