import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/subtask_with_controller.dart';

class SubtaskListController extends StateNotifier<List<SubtaskWithController>> {
  SubtaskListController() : super([]);

  AutoDisposeProvider<TextEditingController> _createControllerProvider(
      {String? text}) {
    return Provider.autoDispose(
        (ref) => TextEditingController(text: text ?? ''));
  }

  void addSubtask(int idx) {
    state = [
      ...state
        ..insert(idx + 1,
            SubtaskWithController(const Subtask(), _createControllerProvider()))
    ];
  }

  void removeSubtask(int idx) {
    if (onlyOneSubtask) return;
    state = [...state..removeAt(idx)];
    log('remove called at $idx ${state.map((e) => e.subtask)}');
  }

  void editSubtaskText(int idx, String text) {
    state = [
      ...state..replaceRange(idx, idx + 1, [state[idx].copyWith(text: text)])
    ];
  }

  bool get onlyOneSubtask => state.length <= 1;
}
