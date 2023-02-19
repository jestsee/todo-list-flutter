import 'package:flutter/cupertino.dart';
import 'package:todo_list/model/subtask.dart';

class SubtaskWithController {
  final Subtask subtask;
  final TextEditingController controller;
  final FocusNode focus;

  SubtaskWithController(this.subtask, this.controller, this.focus);

  factory SubtaskWithController.bySubtask(Subtask subtask) =>
      SubtaskWithController(
          subtask, TextEditingController(text: subtask.text), FocusNode());

  SubtaskWithController copyWith({bool? checked, String? text}) =>
      SubtaskWithController(
          Subtask(
              text: text ?? subtask.text, checked: checked ?? subtask.checked),
          controller,
          focus);
}
