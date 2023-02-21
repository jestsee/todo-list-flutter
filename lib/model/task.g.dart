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
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      priority: $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
          Priority.low,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
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
      'deadline': instance.deadline?.toIso8601String(),
      'priority': _$PriorityEnumMap[instance.priority]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'subtask': instance.subtasks,
    };

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.moderate: 'moderate',
  Priority.high: 'high',
};
