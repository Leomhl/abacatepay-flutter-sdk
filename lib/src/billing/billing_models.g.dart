// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingMetadata _$BillingMetadataFromJson(Map<String, dynamic> json) =>
    BillingMetadata(
      fee: (json['fee'] as num?)?.toInt(),
      returnUrl: json['returnUrl'] as String?,
      completionUrl: json['completionUrl'] as String?,
    );

Map<String, dynamic> _$BillingMetadataToJson(BillingMetadata instance) =>
    <String, dynamic>{
      'fee': instance.fee,
      'returnUrl': instance.returnUrl,
      'completionUrl': instance.completionUrl,
    };

Billing _$BillingFromJson(Map<String, dynamic> json) => Billing(
      id: json['id'] as String,
      url: json['url'] as String,
      amount: (json['amount'] as num).toInt(),
      status: $enumDecode(_$BillingStatusEnumMap, json['status']),
      devMode: json['devMode'] as bool,
      methods: (json['methods'] as List<dynamic>)
          .map((e) => $enumDecode(_$BillingMethodEnumMap, e))
          .toList(),
      products: (json['products'] as List<dynamic>)
          .map((e) => BillingProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      frequency: $enumDecode(_$BillingKindEnumMap, json['frequency']),
      customer: json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : BillingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      nextBilling: json['nextBilling'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BillingToJson(Billing instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'amount': instance.amount,
      'status': _$BillingStatusEnumMap[instance.status]!,
      'devMode': instance.devMode,
      'methods':
          instance.methods.map((e) => _$BillingMethodEnumMap[e]!).toList(),
      'products': instance.products,
      'frequency': _$BillingKindEnumMap[instance.frequency]!,
      'customer': instance.customer,
      'metadata': instance.metadata,
      'nextBilling': instance.nextBilling,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$BillingStatusEnumMap = {
  BillingStatus.pending: 'PENDING',
  BillingStatus.active: 'ACTIVE',
  BillingStatus.expired: 'EXPIRED',
  BillingStatus.cancelled: 'CANCELLED',
  BillingStatus.paid: 'PAID',
  BillingStatus.refunded: 'REFUNDED',
};

const _$BillingMethodEnumMap = {
  BillingMethod.pix: 'PIX',
  BillingMethod.card: 'CARD',
};

const _$BillingKindEnumMap = {
  BillingKind.oneTime: 'ONE_TIME',
  BillingKind.multiplePayments: 'MULTIPLE_PAYMENTS',
};

Map<String, dynamic> _$CreateBillingRequestToJson(
        CreateBillingRequest instance) =>
    <String, dynamic>{
      'frequency': _$BillingKindEnumMap[instance.frequency]!,
      'methods':
          instance.methods.map((e) => _$BillingMethodEnumMap[e]!).toList(),
      'products': instance.products,
      'returnUrl': instance.returnUrl,
      'completionUrl': instance.completionUrl,
      'customerId': instance.customerId,
      'customer': instance.customer,
    };
