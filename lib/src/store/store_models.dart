import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'store_models.g.dart';

/// Represents a store.
@immutable
@JsonSerializable()
class Store {
  /// Creates a [Store].
  const Store({
    required this.id,
    required this.name,
    this.devMode,
    this.email,
    this.document,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [Store] from JSON.
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  /// ID of the store.
  final String id;

  /// Name of the store.
  final String name;

  /// Email of the store.
  final String? email;

  /// Document of the store (CPF/CNPJ).
  final String? document;

  /// Whether the store is in dev mode.
  final bool? devMode;

  /// Phone of the store.
  final String? phone;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the store to JSON.
  Map<String, dynamic> toJson() => _$StoreToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Store && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Store(id: $id, name: $name, email: $email)';
}
