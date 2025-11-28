import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'pix_qr_code_models.g.dart';

/// Status of a PIX QR Code.
@JsonEnum(valueField: 'value')
enum PixQrCodeStatus {
  /// PIX is pending payment.
  pending('PENDING'),

  /// PIX has expired.
  expired('EXPIRED'),

  /// PIX was cancelled.
  cancelled('CANCELLED'),

  /// PIX was paid.
  paid('PAID'),

  /// PIX was refunded.
  refunded('REFUNDED');

  const PixQrCodeStatus(this.value);

  /// The API value.
  final String value;
}

/// Represents a PIX QR Code.
@immutable
@JsonSerializable()
class PixQrCode {
  /// Creates a [PixQrCode].
  const PixQrCode({
    required this.id,
    required this.status,
    this.amount,
    this.devMode,
    this.brCode,
    this.brCodeBase64,
    this.platformFee,
    this.description,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [PixQrCode] from JSON.
  factory PixQrCode.fromJson(Map<String, dynamic> json) =>
      _$PixQrCodeFromJson(json);

  /// ID of the PIX QR Code.
  final String id;

  /// Amount in cents.
  final int? amount;

  /// Status of the PIX.
  final PixQrCodeStatus status;

  /// Whether the PIX is in dev mode.
  final bool? devMode;

  /// Copy and paste code.
  final String? brCode;

  /// QR Code in Base64.
  final String? brCodeBase64;

  /// Platform fee in cents.
  final int? platformFee;

  /// Description of the payment.
  final String? description;

  /// Expiration timestamp.
  final DateTime? expiresAt;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the PIX to JSON.
  Map<String, dynamic> toJson() => _$PixQrCodeToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PixQrCode && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PixQrCode(id: $id, amount: $amount, status: $status)';
}

/// Request to create a PIX QR Code.
@immutable
@JsonSerializable(createFactory: false)
class CreatePixQrCodeRequest {
  /// Creates a [CreatePixQrCodeRequest].
  const CreatePixQrCodeRequest({
    required this.amount,
    this.description,
    this.expiresIn,
  });

  /// Amount in cents.
  final int amount;

  /// Description of the payment.
  final String? description;

  /// Expiration time.
  @JsonKey(toJson: _expiresInToJson)
  final Duration? expiresIn;

  /// Converts the request to JSON.
  Map<String, dynamic> toJson() => _$CreatePixQrCodeRequestToJson(this);

  static int? _expiresInToJson(Duration? duration) => duration?.inSeconds;
}
