// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Task _$$_TaskFromJson(Map<String, dynamic> json) => _$_Task(
      id: json['id'] as String?,
      title: json['title'] as String,
      groupId: json['group_id'] as int?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      deadline: _$JsonConverterFromJson<String, DateTime>(
          json['deadline'], const TimestampSerializer().fromJson),
      priority: $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
          Priority.low,
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['created_at'], const TimestampSerializer().fromJson),
      createdBy: json['created_by'] as String,
      subtasks: (json['subtask'] as List<dynamic>?)
              ?.map((e) => Subtask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_TaskToJson(_$_Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'group_id': instance.groupId,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'deadline': _$JsonConverterToJson<String, DateTime>(
          instance.deadline, const TimestampSerializer().toJson),
      'priority': _$PriorityEnumMap[instance.priority]!,
      'created_at': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const TimestampSerializer().toJson),
      'created_by': instance.createdBy,
      'subtask': instance.subtasks,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.moderate: 'moderate',
  Priority.high: 'high',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
