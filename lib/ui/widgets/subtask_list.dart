import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/subtask_checkbox.dart';

class SubtaskList extends ConsumerWidget {
  const SubtaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtasks = ref.watch(subtaskListControllerProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: subtasks.length,
      itemBuilder: (BuildContext context, int index) {
        return SubtaskCheckbox(
          index: index,
        );
      },
    );
  }
}

// TODO
// 1. ( ) langsung focus di new widget - keyboardnya kejep
// 2. ( ) multiline masih masalah, kalo dibikin textinput.keyboard dia ga bs enter