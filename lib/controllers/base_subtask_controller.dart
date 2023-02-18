import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/subtask_with_controller.dart';

class BaseSubtaskController extends StateNotifier<List<SubtaskWithController>> {
  final Ref ref;
  bool? checked = false;
  BaseSubtaskController(this.ref, {this.checked}) : super([]);

  @override
  void dispose() {
    log("====DISPOSE====");
    for (final subtask in state) {
      log('state disposed');
      subtask.controller.dispose();
      subtask.focus.dispose();
    }
    super.dispose();
  }

  void add(int idx, {Subtask? subtask}) {
    state = [
      ...state
        ..insert(
            idx + 1,
            SubtaskWithController(subtask ?? Subtask(checked: checked ?? false),
                TextEditingController(text: subtask?.text ?? ''), FocusNode()))
    ];
    state[idx + 1].focus.requestFocus();
  }

  void remove(int idx) {
    state[idx].focus.unfocus();

    final controller = state[idx].controller;
    final focus = state[idx].focus;

    controller.dispose();
    focus.dispose();
    log('[DISPOSE] at $idx');

    state = [...state..removeAt(idx)];
    log('remove called at $idx ${state.map((e) => e.subtask)}');
  }

  void editText(int idx, String text) {
    if (idx + 1 > state.length) return;
    state = [
      ...state..replaceRange(idx, idx + 1, [state[idx].copyWith(text: text)])
    ];
  }

  void editCheck(int idx) {}

  void syncSubtasks() {
    state = state.map((e) => e.copyWith(text: e.controller.text)).toList();
    log('sync called ${state.map((e) => e.subtask)}');
  }

  int get length => state.length;
}
