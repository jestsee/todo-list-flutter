import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/subtask.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const Task._();
  const factory Task({
    int? id,
    required String title,
    @JsonKey(name: 'group_id') int? groupId,
    String? longitude,
    String? latitude,
    DateTime? deadline,
    @Default(Priority.low) Priority priority,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'created_by') required String createdBy,
    @Default([]) @JsonKey(name: 'subtask') List<Subtask>? subtasks,
  }) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);

  bool get hasSubtasks => subtasks!.isNotEmpty;
}
