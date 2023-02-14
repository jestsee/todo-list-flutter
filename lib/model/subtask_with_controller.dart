import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';

class SubtaskWithController {
  final Subtask subtask;
  final AutoDisposeProvider<TextEditingController> controller;

  SubtaskWithController(this.subtask, this.controller);

  SubtaskWithController copyWith({bool? checked, String? text}) =>
      SubtaskWithController(
          Subtask(
              text: text ?? subtask.text, checked: checked ?? subtask.checked),
          controller);
}
