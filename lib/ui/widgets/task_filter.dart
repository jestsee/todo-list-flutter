import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/model/priority.dart';

import 'priority_chip.dart';

class TaskFilter extends HookWidget {
  const TaskFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.all(3),
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.filter_alt_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              builder: (context) => const Filter(),
            );
          },
        ));
  }
}

class Filter extends HookWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPriority = useState<Priority>(Priority.high);

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Text('Priority', style: Theme.of(context).textTheme.headline3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PriorityChip(
                priority: Priority.high,
                selected: selectedPriority.value == Priority.high,
                onPressed: () {
                  selectedPriority.value = Priority.high;
                },
              ),
              PriorityChip(
                priority: Priority.medium,
                selected: selectedPriority.value == Priority.medium,
                onPressed: () {
                  selectedPriority.value = Priority.medium;
                },
              ),
              PriorityChip(
                priority: Priority.low,
                selected: selectedPriority.value == Priority.low,
                onPressed: () {
                  selectedPriority.value = Priority.low;
                },
              )
            ],
          ),
          Text('Date', style: Theme.of(context).textTheme.headline3),
        ],
      ),
    );
  }
}
