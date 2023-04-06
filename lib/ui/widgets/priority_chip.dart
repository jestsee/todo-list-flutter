import 'package:flutter/material.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/extensions.dart';

class PriorityChip extends StatelessWidget {
  final void Function()? onPressed;
  final Priority priority;
  final bool selected;
  const PriorityChip(
      {super.key,
      required this.priority,
      this.onPressed,
      this.selected = false});
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: !selected
          ? StadiumBorder(
              side: BorderSide(color: Color(priorityColor[priority]!.value)))
          : null,
      backgroundColor: selected ? priorityColor[priority] : Colors.transparent,
      label: Text(
        priority.name.capitalize(),
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : priorityColor[priority]),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onPressed: onPressed ?? () {},
    );
  }
}
