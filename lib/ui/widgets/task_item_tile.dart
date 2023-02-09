import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/task_item.dart';

class TaskItemTile extends HookConsumerWidget {
  const TaskItemTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskItem = ref.read(currentTaskItem);
    return TaskItem(task: taskItem);
  }
}
