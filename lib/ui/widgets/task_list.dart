import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/task_item_tile.dart';

class TaskList extends HookConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListState = ref.read(taskListControllerProvider);
    return taskListState.when(
        data: (data) => MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ProviderScope(
                        overrides: [currentTaskItem.overrideWithValue(item)],
                        child: const TaskItemTile());
                  }),
            ),
        error: ((error, stackTrace) => const Text('error')),
        loading: (() => const Text('loading')));
  }
}
