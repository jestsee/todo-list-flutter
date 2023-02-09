import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class TaskList extends HookConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListState = ref.read(taskListControllerProvider);
    return taskListState.when(
        // TODO masih belom bisa mapping subtask
        data: ((data) => Text(data[1].subtasks.toString())),
        error: ((error, stackTrace) => const Text('error')),
        loading: (() => const Text('loading')));
  }
}
