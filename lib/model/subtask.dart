import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'subtask.freezed.dart';
part 'subtask.g.dart';

@freezed
class Subtask with _$Subtask {
  const Subtask._();
  const factory Subtask({
    required String text,
    required bool checked,
  }) = _Subtask;

  factory Subtask.fromJson(Map<String, Object?> json) =>
      _$SubtaskFromJson(json);

  bool get isChecked => this.checked;

  Subtask checkTask() => copyWith(text: text, checked: true);

  Subtask uncheckTask() => copyWith(text: text, checked: false);
}
