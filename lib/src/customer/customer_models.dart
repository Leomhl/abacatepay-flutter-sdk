import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'customer_models.g.dart';

/// Metadata for a customer.
@immutable
@JsonSerializable()
class CustomerMetadata {
  /// Creates a [CustomerMetadata].
  const CustomerMetadata({
    required this.email,
    this.name,
    this.cellphone,
    this.taxId,
  });

  /// Creates a [CustomerMetadata] from JSON.
  factory CustomerMetadata.fromJson(Map<String, dynamic> json) =>
      _$CustomerMetadataFromJson(json);

  /// Email of the customer.
  final String email;

  /// Name of the customer.
  final String? name;

  /// Cellphone of the customer.
  final String? cellphone;

  /// Tax ID (CPF/CNPJ) of the customer.
  final String? taxId;

  /// Converts the metadata to JSON.
  Map<String, dynamic> toJson() => _$CustomerMetadataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerMetadata &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          name == other.name &&
          cellphone == other.cellphone &&
          taxId == other.taxId;

  @override
  int get hashCode =>
      email.hashCode ^ name.hashCode ^ cellphone.hashCode ^ taxId.hashCode;

  @override
  String toString() =>
      'CustomerMetadata(email: $email, name: $name, cellphone: $cellphone, '
      'taxId: $taxId)';
}

/// Represents a customer.
@immutable
@JsonSerializable()
class Customer {
  /// Creates a [Customer].
  const Customer({
    required this.id,
    required this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [Customer] from JSON.
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  /// ID of the customer.
  final String id;

  /// Metadata of the customer.
  final CustomerMetadata metadata;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the customer to JSON.
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Customer &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata;

  @override
  int get hashCode => id.hashCode ^ metadata.hashCode;

  @override
  String toString() =>
      'Customer(id: $id, metadata: $metadata, createdAt: $createdAt, '
      'updatedAt: $updatedAt)';
}

/// Request to create a customer.
@immutable
@JsonSerializable(createFactory: false)
class CreateCustomerRequest {
  /// Creates a [CreateCustomerRequest].
  const CreateCustomerRequest({
    required this.email,
    this.name,
    this.cellphone,
    this.taxId,
  });

  /// Email of the customer.
  final String email;

  /// Name of the customer.
  final String? name;

  /// Cellphone of the customer.
  final String? cellphone;

  /// Tax ID (CPF/CNPJ) of the customer.
  final String? taxId;

  /// Converts the request to JSON.
  Map<String, dynamic> toJson() => _$CreateCustomerRequestToJson(this);
}
