import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/subtask_with_controller.dart';

class BaseSubtaskController extends StateNotifier<List<SubtaskWithController>> {
  final Ref ref;
  final List<Subtask>? subtasks;
  bool? checked = false;
  BaseSubtaskController(this.ref, {this.checked, this.subtasks}) : super([]) {
    if (subtasks != null) set(subtasks!);
  }

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

  void set(List<Subtask> subtasks) {
    if (mounted) {
      state = subtasks.map((e) => SubtaskWithController.bySubtask(e)).toList();
    }
    log('set called ${state.map((e) => e.subtask)}');
  }

  void add(int idx, {Subtask? subtask}) {
    log('add called ${state.map((e) => e.subtask)}');
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

  void editCheck(int idx) {}

  void syncSubtasks() {
    state = state.map((e) => e.copyWith(text: e.controller.text)).toList();
    log('[SYNC] ${state.map((e) => e.subtask)}');
  }

  int get length => state.length;
}
