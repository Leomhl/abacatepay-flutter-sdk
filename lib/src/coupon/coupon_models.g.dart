// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['id'] as String,
      code: json['code'] as String?,
      discountKind:
          $enumDecodeNullable(_$DiscountKindEnumMap, json['discountKind']),
      discount: (json['discount'] as num?)?.toInt(),
      maxRedeems: (json['maxRedeems'] as num?)?.toInt(),
      redeemsCount: (json['redeemsCount'] as num?)?.toInt(),
      status: $enumDecodeNullable(_$CouponStatusEnumMap, json['status']),
      devMode: json['devMode'] as bool?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discountKind': _$DiscountKindEnumMap[instance.discountKind],
      'discount': instance.discount,
      'maxRedeems': instance.maxRedeems,
      'redeemsCount': instance.redeemsCount,
      'status': _$CouponStatusEnumMap[instance.status],
      'devMode': instance.devMode,
      'notes': instance.notes,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DiscountKindEnumMap = {
  DiscountKind.percentage: 'PERCENTAGE',
  DiscountKind.fixed: 'FIXED',
};

const _$CouponStatusEnumMap = {
  CouponStatus.active: 'ACTIVE',
  CouponStatus.deleted: 'DELETED',
  CouponStatus.disabled: 'DISABLED',
};
