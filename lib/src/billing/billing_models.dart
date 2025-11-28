import 'package:abacatepay_flutter/src/customer/customer_models.dart';
import 'package:abacatepay_flutter/src/product/product_models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'billing_models.g.dart';

/// Status of a billing.
@JsonEnum(valueField: 'value')
enum BillingStatus {
  /// Billing is pending payment.
  pending('PENDING'),

  /// Billing link is active (for MULTIPLE_PAYMENTS).
  active('ACTIVE'),

  /// Billing has expired.
  expired('EXPIRED'),

  /// Billing was cancelled.
  cancelled('CANCELLED'),

  /// Billing was paid.
  paid('PAID'),

  /// Billing was refunded.
  refunded('REFUNDED');

  const BillingStatus(this.value);

  /// The API value.
  final String value;
}

/// Payment method.
@JsonEnum(valueField: 'value')
enum BillingMethod {
  /// PIX payment.
  pix('PIX'),

  /// Card payment.
  card('CARD');

  const BillingMethod(this.value);

  /// The API value.
  final String value;
}

/// Billing frequency.
@JsonEnum(valueField: 'value')
enum BillingKind {
  /// One-time payment.
  oneTime('ONE_TIME'),

  /// Multiple payments allowed.
  multiplePayments('MULTIPLE_PAYMENTS');

  const BillingKind(this.value);

  /// The API value.
  final String value;
}

/// Metadata for a billing.
@immutable
@JsonSerializable()
class BillingMetadata {
  /// Creates a [BillingMetadata].
  const BillingMetadata({
    this.fee,
    this.returnUrl,
    this.completionUrl,
  });

  /// Creates a [BillingMetadata] from JSON.
  factory BillingMetadata.fromJson(Map<String, dynamic> json) =>
      _$BillingMetadataFromJson(json);

  /// Fee in cents.
  final int? fee;

  /// Return URL.
  final String? returnUrl;

  /// Completion URL.
  final String? completionUrl;

  /// Converts the metadata to JSON.
  Map<String, dynamic> toJson() => _$BillingMetadataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingMetadata &&
          runtimeType == other.runtimeType &&
          fee == other.fee &&
          returnUrl == other.returnUrl &&
          completionUrl == other.completionUrl;

  @override
  int get hashCode =>
      fee.hashCode ^ returnUrl.hashCode ^ completionUrl.hashCode;
}

/// Represents a billing.
@immutable
@JsonSerializable()
class Billing {
  /// Creates a [Billing].
  const Billing({
    required this.id,
    required this.url,
    required this.amount,
    required this.status,
    required this.devMode,
    required this.methods,
    required this.products,
    required this.frequency,
    this.customer,
    this.metadata,
    this.nextBilling,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [Billing] from JSON.
  factory Billing.fromJson(Map<String, dynamic> json) =>
      _$BillingFromJson(json);

  /// ID of the billing.
  final String id;

  /// Payment URL.
  final String url;

  /// Amount in cents.
  final int amount;

  /// Status of the billing.
  final BillingStatus status;

  /// Whether the billing is in dev mode.
  final bool devMode;

  /// Accepted payment methods.
  final List<BillingMethod> methods;

  /// Products in the billing.
  final List<BillingProduct> products;

  /// Billing frequency.
  final BillingKind frequency;

  /// Customer information.
  final Customer? customer;

  /// Billing metadata.
  final BillingMetadata? metadata;

  /// Next billing date.
  final String? nextBilling;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the billing to JSON.
  Map<String, dynamic> toJson() => _$BillingToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Billing && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Billing(id: $id, url: $url, amount: $amount, status: $status)';
}

/// Request to create a billing.
@immutable
@JsonSerializable(createFactory: false)
class CreateBillingRequest {
  /// Creates a [CreateBillingRequest].
  const CreateBillingRequest({
    required this.frequency,
    required this.methods,
    required this.products,
    this.returnUrl,
    this.completionUrl,
    this.customerId,
    this.customer,
  });

  /// Billing frequency.
  final BillingKind frequency;

  /// Accepted payment methods.
  final List<BillingMethod> methods;

  /// Products in the billing.
  final List<Product> products;

  /// Return URL.
  final String? returnUrl;

  /// Completion URL.
  final String? completionUrl;

  /// ID of an existing customer.
  final String? customerId;

  /// Customer metadata for a new customer.
  final CustomerMetadata? customer;

  /// Converts the request to JSON.
  Map<String, dynamic> toJson() => _$CreateBillingRequestToJson(this);
}

/// Request to create a billing link (allows multiple payments).
///
/// This is a convenience class that creates a billing with
/// [BillingKind.multiplePayments] frequency, allowing the same
/// payment link to be used multiple times.
@immutable
class CreateBillingLinkRequest {
  /// Creates a [CreateBillingLinkRequest].
  const CreateBillingLinkRequest({
    required this.methods,
    required this.products,
    this.returnUrl,
    this.completionUrl,
    this.customerId,
    this.customer,
  });

  /// Accepted payment methods.
  final List<BillingMethod> methods;

  /// Products in the billing.
  final List<Product> products;

  /// Return URL.
  final String? returnUrl;

  /// Completion URL.
  final String? completionUrl;

  /// ID of an existing customer.
  final String? customerId;

  /// Customer metadata for a new customer.
  final CustomerMetadata? customer;

  /// Converts the request to JSON.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'frequency': BillingKind.multiplePayments.value,
      'methods': methods.map((e) => e.value).toList(),
      'products': products.map((e) => e.toJson()).toList(),
    };
    if (returnUrl != null) json['returnUrl'] = returnUrl;
    if (completionUrl != null) json['completionUrl'] = completionUrl;
    if (customerId != null) json['customerId'] = customerId;
    if (customer != null) json['customer'] = customer!.toJson();
    return json;
  }
}
