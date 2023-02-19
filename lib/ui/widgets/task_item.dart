import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/index.dart';
import 'package:todo_list/ui/widgets/badge.dart';
import 'package:todo_list/ui/widgets/constants.dart';

final priorityMap = {
  Priority.low: BadgeVariant.low,
  Priority.moderate: BadgeVariant.moderate,
  Priority.high: BadgeVariant.high,
};

class TaskItem extends ConsumerWidget {
  final Task task;
  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gap = 10.0;
    return GestureDetector(
      onTap: () {
        showTaskDialog(context, task: task);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(task.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Badge(
                  text: 'Priority',
                  variant: priorityMap[task.priority]!,
                ),
              ],
            ),
            const SizedBox(height: gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Badge(
                  text: task.groupId != null ? 'Group' : 'Personal',
                  outline: true,
                  variant: BadgeVariant.other,
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, size: 16),
                    const SizedBox(width: 4),
                    // TODO ubah createdAt jd deadline
                    // Text(DateFormat.yMMMd().format(task.createdAt!)),
                  ],
                )
              ],
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: task.subtasks!
                  .take(2)
                  .map(
                    (subtask) => SizedBox(
                      height: 30,
                      child: CheckboxListTile(
                        value: subtask.checked,
                        onChanged: ((value) => {}),
                        title: Text(subtask.text,
                            style: TextStyle(
                                decoration: subtask.checked
                                    ? TextDecoration.lineThrough
                                    : null)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  )
                  .toList(),
            ),
            task.subtasks!.length > 2
                ? const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      '...',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
