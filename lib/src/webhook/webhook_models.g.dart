// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebhookEvent _$WebhookEventFromJson(Map<String, dynamic> json) => WebhookEvent(
      id: json['id'] as String,
      event: $enumDecode(_$WebhookEventTypeEnumMap, json['event']),
      devMode: json['devMode'] as bool,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WebhookEventToJson(WebhookEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event': _$WebhookEventTypeEnumMap[instance.event]!,
      'devMode': instance.devMode,
      'data': instance.data,
    };

const _$WebhookEventTypeEnumMap = {
  WebhookEventType.billingPaid: 'billing.paid',
  WebhookEventType.withdrawDone: 'withdraw.done',
  WebhookEventType.withdrawFailed: 'withdraw.failed',
};
