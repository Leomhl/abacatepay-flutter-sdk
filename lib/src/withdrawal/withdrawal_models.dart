import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'withdrawal_models.g.dart';

/// Status of a withdrawal.
@JsonEnum(valueField: 'value')
enum WithdrawalStatus {
  /// Withdrawal is pending.
  pending('PENDING'),

  /// Withdrawal is processing.
  processing('PROCESSING'),

  /// Withdrawal was completed.
  completed('COMPLETED'),

  /// Withdrawal failed.
  failed('FAILED'),

  /// Withdrawal was cancelled.
  cancelled('CANCELLED');

  const WithdrawalStatus(this.value);

  /// The API value.
  final String value;
}

/// Type of bank account.
@JsonEnum(valueField: 'value')
enum AccountType {
  /// Checking account.
  checking('CHECKING'),

  /// Savings account.
  savings('SAVINGS');

  const AccountType(this.value);

  /// The API value.
  final String value;
}

/// Represents a bank account.
@immutable
@JsonSerializable()
class BankAccount {
  /// Creates a [BankAccount].
  const BankAccount({
    required this.bankCode,
    required this.agency,
    required this.account,
    required this.accountType,
    required this.holderName,
    required this.holderDocument,
  });

  /// Creates a [BankAccount] from JSON.
  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);

  /// Bank code.
  final String bankCode;

  /// Agency number.
  final String agency;

  /// Account number.
  final String account;

  /// Type of account.
  final AccountType accountType;

  /// Name of the account holder.
  final String holderName;

  /// Document of the account holder (CPF/CNPJ).
  final String holderDocument;

  /// Converts the bank account to JSON.
  Map<String, dynamic> toJson() => _$BankAccountToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAccount &&
          runtimeType == other.runtimeType &&
          bankCode == other.bankCode &&
          agency == other.agency &&
          account == other.account;

  @override
  int get hashCode => bankCode.hashCode ^ agency.hashCode ^ account.hashCode;

  @override
  String toString() =>
      'BankAccount(bankCode: $bankCode, agency: $agency, account: $account)';
}

/// Represents a withdrawal.
@immutable
@JsonSerializable()
class Withdrawal {
  /// Creates a [Withdrawal].
  const Withdrawal({
    required this.id,
    required this.amount,
    required this.status,
    required this.devMode,
    this.bankAccount,
    this.processedAt,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a [Withdrawal] from JSON.
  factory Withdrawal.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalFromJson(json);

  /// ID of the withdrawal.
  final String id;

  /// Amount in cents.
  final int amount;

  /// Status of the withdrawal.
  final WithdrawalStatus status;

  /// Whether the withdrawal is in dev mode.
  final bool devMode;

  /// Bank account for the withdrawal.
  final BankAccount? bankAccount;

  /// Processing timestamp.
  final DateTime? processedAt;

  /// Creation timestamp.
  final DateTime? createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;

  /// Converts the withdrawal to JSON.
  Map<String, dynamic> toJson() => _$WithdrawalToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Withdrawal && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Withdrawal(id: $id, amount: $amount, status: $status)';
}

/// Request to create a withdrawal.
@immutable
@JsonSerializable(createFactory: false)
class CreateWithdrawalRequest {
  /// Creates a [CreateWithdrawalRequest].
  const CreateWithdrawalRequest({
    required this.amount,
    required this.bankAccount,
  });

  /// Amount in cents.
  final int amount;

  /// Bank account for the withdrawal.
  final BankAccount bankAccount;

  /// Converts the request to JSON.
  Map<String, dynamic> toJson() => _$CreateWithdrawalRequestToJson(this);
}
