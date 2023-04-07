import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/task_item.dart';

class TaskList extends HookConsumerWidget {
  final bool filtered;
  const TaskList({super.key, this.filtered = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListState = ref.watch(taskListControllerProvider);
    final taskAction = ref.read(taskListControllerProvider.notifier);
    final filteredTask = ref.watch(filteredTasksProvider);
    return taskListState.when(
      error: ((error, stackTrace) => const Text('error')),
      loading: (() => const Text('loading')),
      data: (_) {
        return Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                separatorBuilder: ((context, index) => const Divider(
                      color: Colors.white,
                    )),
                itemCount: filteredTask.length,
                itemBuilder: (context, index) {
                  final item = filteredTask[index];
                  return Slidable(
                      key: Key(item.id!),
                      endActionPane:
                          ActionPane(motion: const BehindMotion(), children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            taskAction.deleteTask(id: (item.id!));
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                      ]),
                      child: TaskItem(task: item));
                }),
          ),
        );
      },
    );
  }
}
