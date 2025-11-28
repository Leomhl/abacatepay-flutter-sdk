// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as String,
      name: json['name'] as String,
      devMode: json['devMode'] as bool?,
      email: json['email'] as String?,
      document: json['document'] as String?,
      phone: json['phone'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'document': instance.document,
      'devMode': instance.devMode,
      'phone': instance.phone,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
