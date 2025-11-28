import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'coupon_models.g.dart';

/// Status of a coupon.
@JsonEnum(valueField: 'value')
enum CouponStatus {
  /// Coupon is active.
  active('ACTIVE'),

  /// Coupon was deleted.
  deleted('DELETED'),

  /// Coupon is disabled.
  disabled('DISABLED');

  const CouponStatus(this.value);

  /// The API value.
  final String value;
}

/// Type of discount.
@JsonEnum(valueField: 'value')
enum DiscountKind {
  /// Percentage discount.
  percentage('PERCENTAGE'),

  /// Fixed amount discount.
  fixed('FIXED');

  const DiscountKind(this.value);

  /// The API value.
  final String value;
}

/// Represents a coupon.
@immutable
@JsonSerializable()
class Coupon {
  /// Creates a [Coupon].
  const Coupon({
    required this.id,
    this.code,
    this.discountKind,
    this.discount,
    this.maxRedeems,
    this.redeemsCount,
    this.status,
    this.devMode,
    this.notes,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [Coupon] from JSON.
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  /// ID of the coupon.
  final String id;

  /// Coupon code.
  final String? code;

  /// Type of discount.
  final DiscountKind? discountKind;

  /// Discount value.
  final int? discount;

  /// Maximum redeems (-1 for unlimited).
  final int? maxRedeems;

  /// Current redeems count.
  final int? redeemsCount;

  /// Status of the coupon.
  final CouponStatus? status;

  /// Whether the coupon is in dev mode.
  final bool? devMode;

  /// Notes about the coupon.
  final String? notes;

  /// Additional metadata.
  final Map<String, dynamic>? metadata;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the coupon to JSON.
  Map<String, dynamic> toJson() => _$CouponToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coupon && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Coupon(id: $id, code: $code, discount: $discount, status: $status)';
}

/// Request to create a coupon.
@immutable
class CreateCouponRequest {
  /// Creates a [CreateCouponRequest].
  const CreateCouponRequest({
    required this.code,
    required this.discountKind,
    required this.discount,
    this.maxRedeems = -1,
    this.notes,
    this.metadata,
  });

  /// Coupon code.
  final String code;

  /// Type of discount.
  final DiscountKind discountKind;

  /// Discount value.
  final int discount;

  /// Maximum redeems (-1 for unlimited).
  final int maxRedeems;

  /// Notes about the coupon.
  final String? notes;

  /// Additional metadata.
  final Map<String, dynamic>? metadata;

  /// Converts the request to JSON (excludes null values).
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'code': code,
      'discountKind': discountKind.value,
      'discount': discount,
      'maxRedeems': maxRedeems,
    };
    if (notes != null) json['notes'] = notes;
    if (metadata != null) json['metadata'] = metadata;
    return json;
  }
}
