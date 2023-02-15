import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/subtask_with_controller.dart';

class SubtaskListController extends StateNotifier<List<SubtaskWithController>> {
  final List<TextEditingController> _disposedControllerList = [];
  final List<FocusNode> _disposedFocusList = [];
  SubtaskListController() : super([]);

  @override
  void dispose() {
    log("====DISPOSE====");
    for (final subtask in state) {
      log('state disposed');
      subtask.controller.dispose();
      subtask.focus.dispose();
    }
    super.dispose();
    for (final controller in _disposedControllerList) {
      log('controller disposed');
      controller.dispose();
    }
    for (final focus in _disposedFocusList) {
      log('focus disposed');
      focus.dispose();
    }
  }

  void add(int idx) {
    state = [
      ...state
        ..insert(
            idx + 1,
            SubtaskWithController(
                const Subtask(), TextEditingController(), FocusNode()))
    ];
    state[idx + 1].focus.requestFocus();
  }

  void remove(int idx) {
    if (onlyOneSubtask) return;

    state[idx].focus.unfocus();

    _disposedControllerList.add(state[idx].controller);
    _disposedFocusList.add(state[idx].focus);

    state = [...state..removeAt(idx)];
    log('remove called at $idx ${state.map((e) => e.subtask)}');
  }

  void editText(int idx, String text) {
    if (idx + 1 > state.length) return;
    state = [
      ...state..replaceRange(idx, idx + 1, [state[idx].copyWith(text: text)])
    ];
  }

  void editCheck(int idx, bool check) {
    state[idx].focus.unfocus();
    state = [
      ...state
        ..replaceRange(idx, idx + 1, [state[idx].copyWith(checked: check)])
    ];

    // reorder
    state = [
      ...state
        ..sort((a, b) {
          if (b.subtask.checked) {
            return -1;
          }
          return 1;
        })
    ];
    log('reorder ${state.map((e) => e.subtask)}');
  }

  bool get onlyOneSubtask => state.length <= 1;
}
