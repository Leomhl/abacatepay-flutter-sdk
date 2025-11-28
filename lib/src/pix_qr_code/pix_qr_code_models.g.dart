// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pix_qr_code_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixQrCode _$PixQrCodeFromJson(Map<String, dynamic> json) => PixQrCode(
      id: json['id'] as String,
      status: $enumDecode(_$PixQrCodeStatusEnumMap, json['status']),
      amount: (json['amount'] as num?)?.toInt(),
      devMode: json['devMode'] as bool?,
      brCode: json['brCode'] as String?,
      brCodeBase64: json['brCodeBase64'] as String?,
      platformFee: (json['platformFee'] as num?)?.toInt(),
      description: json['description'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PixQrCodeToJson(PixQrCode instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': _$PixQrCodeStatusEnumMap[instance.status]!,
      'devMode': instance.devMode,
      'brCode': instance.brCode,
      'brCodeBase64': instance.brCodeBase64,
      'platformFee': instance.platformFee,
      'description': instance.description,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PixQrCodeStatusEnumMap = {
  PixQrCodeStatus.pending: 'PENDING',
  PixQrCodeStatus.expired: 'EXPIRED',
  PixQrCodeStatus.cancelled: 'CANCELLED',
  PixQrCodeStatus.paid: 'PAID',
  PixQrCodeStatus.refunded: 'REFUNDED',
};

Map<String, dynamic> _$CreatePixQrCodeRequestToJson(
        CreatePixQrCodeRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'description': instance.description,
      'expiresIn': CreatePixQrCodeRequest._expiresInToJson(instance.expiresIn),
    };
