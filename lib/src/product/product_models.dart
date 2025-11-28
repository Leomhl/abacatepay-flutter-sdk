import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'product_models.g.dart';

/// Represents a product in a billing.
@immutable
@JsonSerializable()
class Product {
  /// Creates a [Product].
  const Product({
    required this.externalId,
    required this.name,
    required this.quantity,
    required this.price,
    this.description,
  });

  /// Creates a [Product] from JSON.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  /// External ID of the product.
  final String externalId;

  /// Name of the product.
  final String name;

  /// Quantity of the product.
  final int quantity;

  /// Price of the product in cents.
  final int price;

  /// Description of the product.
  final String? description;

  /// Converts the product to JSON.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          externalId == other.externalId &&
          name == other.name &&
          quantity == other.quantity &&
          price == other.price &&
          description == other.description;

  @override
  int get hashCode =>
      externalId.hashCode ^
      name.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      description.hashCode;

  @override
  String toString() =>
      'Product(externalId: $externalId, name: $name, quantity: $quantity, '
      'price: $price, description: $description)';
}

/// Represents a product in a billing response.
@immutable
@JsonSerializable()
class BillingProduct {
  /// Creates a [BillingProduct].
  const BillingProduct({
    required this.id,
    required this.externalId,
    required this.quantity,
  });

  /// Creates a [BillingProduct] from JSON.
  factory BillingProduct.fromJson(Map<String, dynamic> json) =>
      _$BillingProductFromJson(json);

  /// ID of the product.
  final String id;

  /// External ID of the product.
  final String externalId;

  /// Quantity of the product.
  final int quantity;

  /// Converts the product to JSON.
  Map<String, dynamic> toJson() => _$BillingProductToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingProduct &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          externalId == other.externalId &&
          quantity == other.quantity;

  @override
  int get hashCode => id.hashCode ^ externalId.hashCode ^ quantity.hashCode;

  @override
  String toString() =>
      'BillingProduct(id: $id, externalId: $externalId, quantity: $quantity)';
}
