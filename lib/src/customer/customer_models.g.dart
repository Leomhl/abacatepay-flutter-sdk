// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerMetadata _$CustomerMetadataFromJson(Map<String, dynamic> json) =>
    CustomerMetadata(
      email: json['email'] as String,
      name: json['name'] as String?,
      cellphone: json['cellphone'] as String?,
      taxId: json['taxId'] as String?,
    );

Map<String, dynamic> _$CustomerMetadataToJson(CustomerMetadata instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'cellphone': instance.cellphone,
      'taxId': instance.taxId,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String,
      metadata:
          CustomerMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Map<String, dynamic> _$CreateCustomerRequestToJson(
        CreateCustomerRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'cellphone': instance.cellphone,
      'taxId': instance.taxId,
    };
