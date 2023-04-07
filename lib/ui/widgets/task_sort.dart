import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/task_sort_enum.dart';
import 'package:todo_list/provider.dart';

import 'custom_button.dart';

class TaskSort extends StatelessWidget {
  const TaskSort({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.sort_rounded, size: 18),
        label: const Text('Sort'),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            builder: (context) => const Sort(),
          );
        },
      ),
    );
  }
}

class Sort extends HookConsumerWidget {
  const Sort({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = useState<TaskSortEnum>(ref.read(taskSortProvider));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text('Sort task by', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 16),
          RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Closest deadline'),
              value: TaskSortEnum.closestDeadline,
              groupValue: sort.value,
              onChanged: (value) => sort.value = value!),
          RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Furthest deadline'),
              value: TaskSortEnum.furthestDeadline,
              groupValue: sort.value,
              onChanged: (value) => sort.value = value!),
          RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Highest priority'),
              value: TaskSortEnum.highestPriority,
              groupValue: sort.value,
              onChanged: (value) => sort.value = value!),
          RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Lowest priority'),
              value: TaskSortEnum.lowestPriority,
              groupValue: sort.value,
              onChanged: (value) => sort.value = value!),
          const SizedBox(height: 20),
          CustomButton(
            full: true,
            onPressed: (() {
              ref.read(taskSortProvider.notifier).state = sort.value;
              Navigator.of(context).pop();
            }),
            child: const Text(
              'Apply',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
