// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      externalId: json['externalId'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'externalId': instance.externalId,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'description': instance.description,
    };

BillingProduct _$BillingProductFromJson(Map<String, dynamic> json) =>
    BillingProduct(
      id: json['id'] as String,
      externalId: json['externalId'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BillingProductToJson(BillingProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'quantity': instance.quantity,
    };
