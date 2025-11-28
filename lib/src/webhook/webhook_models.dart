import 'package:abacatepay_flutter/src/billing/billing_models.dart';
import 'package:abacatepay_flutter/src/withdrawal/withdrawal_models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'webhook_models.g.dart';

/// Type of webhook event.
@JsonEnum(valueField: 'value')
enum WebhookEventType {
  /// Billing was paid.
  billingPaid('billing.paid'),

  /// Withdrawal was completed.
  withdrawDone('withdraw.done'),

  /// Withdrawal failed.
  withdrawFailed('withdraw.failed');

  const WebhookEventType(this.value);

  /// The API value.
  final String value;
}

/// Represents a webhook event.
@immutable
@JsonSerializable()
class WebhookEvent {
  /// Creates a [WebhookEvent].
  const WebhookEvent({
    required this.id,
    required this.event,
    required this.devMode,
    this.data,
  });

  /// Creates a [WebhookEvent] from JSON.
  factory WebhookEvent.fromJson(Map<String, dynamic> json) =>
      _$WebhookEventFromJson(json);

  /// ID of the event.
  final String id;

  /// Type of the event.
  final WebhookEventType event;

  /// Whether the event is in dev mode.
  final bool devMode;

  /// Event data.
  final Map<String, dynamic>? data;

  /// Converts the event to JSON.
  Map<String, dynamic> toJson() => _$WebhookEventToJson(this);

  /// Gets the billing from the event data.
  Billing? getBilling() {
    if (event != WebhookEventType.billingPaid || data == null) return null;
    return Billing.fromJson(data!);
  }

  /// Gets the withdrawal from the event data.
  Withdrawal? getWithdrawal() {
    if (event != WebhookEventType.withdrawDone &&
        event != WebhookEventType.withdrawFailed) {
      return null;
    }
    if (data == null) return null;
    return Withdrawal.fromJson(data!);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WebhookEvent &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WebhookEvent(id: $id, event: $event)';
}
