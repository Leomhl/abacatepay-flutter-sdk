// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      bankCode: json['bankCode'] as String,
      agency: json['agency'] as String,
      account: json['account'] as String,
      accountType: $enumDecode(_$AccountTypeEnumMap, json['accountType']),
      holderName: json['holderName'] as String,
      holderDocument: json['holderDocument'] as String,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'agency': instance.agency,
      'account': instance.account,
      'accountType': _$AccountTypeEnumMap[instance.accountType]!,
      'holderName': instance.holderName,
      'holderDocument': instance.holderDocument,
    };

const _$AccountTypeEnumMap = {
  AccountType.checking: 'CHECKING',
  AccountType.savings: 'SAVINGS',
};

Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) => Withdrawal(
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      status: $enumDecode(_$WithdrawalStatusEnumMap, json['status']),
      devMode: json['devMode'] as bool,
      bankAccount: json['bankAccount'] == null
          ? null
          : BankAccount.fromJson(json['bankAccount'] as Map<String, dynamic>),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WithdrawalToJson(Withdrawal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'status': _$WithdrawalStatusEnumMap[instance.status]!,
      'devMode': instance.devMode,
      'bankAccount': instance.bankAccount,
      'processedAt': instance.processedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$WithdrawalStatusEnumMap = {
  WithdrawalStatus.pending: 'PENDING',
  WithdrawalStatus.processing: 'PROCESSING',
  WithdrawalStatus.completed: 'COMPLETED',
  WithdrawalStatus.failed: 'FAILED',
  WithdrawalStatus.cancelled: 'CANCELLED',
};

Map<String, dynamic> _$CreateWithdrawalRequestToJson(
        CreateWithdrawalRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'bankAccount': instance.bankAccount,
    };
