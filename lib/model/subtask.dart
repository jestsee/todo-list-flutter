import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'subtask.freezed.dart';
part 'subtask.g.dart';

@freezed
class Subtask with _$Subtask {
  const Subtask._();
  const factory Subtask({
    @Default('') String text,
    @Default(false) bool checked,
  }) = _Subtask;

  factory Subtask.fromJson(Map<String, Object?> json) =>
      _$SubtaskFromJson(json);

  Subtask checkTask() => copyWith(checked: true);

  Subtask uncheckTask() => copyWith(checked: false);

  Subtask changeChecked(bool checked) => copyWith(checked: checked);

  Subtask changeText(String text) => copyWith(text: text);
}
