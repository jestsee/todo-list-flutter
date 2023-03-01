import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/timestamp_serializer.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const Task._();
  const factory Task({
    String? id,
    required String title,
    @JsonKey(name: 'group_id') int? groupId,
    String? longitude,
    String? latitude,
    @TimestampSerializer() DateTime? deadline,
    @Default(Priority.low) Priority priority,
    @JsonKey(name: 'created_at') @TimestampSerializer() DateTime? createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @Default([]) @JsonKey(name: 'subtask') List<Subtask>? subtasks,
  }) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);

  Map<String, dynamic> toCleaned() => toJson()
    ..remove('id')
    ..remove('created_at');

  bool get hasSubtasks => subtasks!.isNotEmpty;
}
