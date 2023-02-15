import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class SubtaskCheckbox extends HookConsumerWidget {
  final int index;
  const SubtaskCheckbox({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtasksAction = ref.read(subtaskListControllerProvider.notifier);
    final subtaskProvider = ref.watch(subtaskListControllerProvider)[index];
    final subtask = subtaskProvider.subtask;
    final controller = subtaskProvider.controller;
    final focus = subtaskProvider.focus;
    final nextSubtask =
        ref.watch(subtaskListControllerProvider).length > index + 1
            ? ref.watch(subtaskListControllerProvider)[index + 1].subtask
            : null;

    final hasFocus = useState(false);

    bool borderArea() =>
        nextSubtask != null && !subtask.checked && nextSubtask.checked;

    return Container(
      decoration: borderArea()
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.75, color: Colors.black26),
              ), //add it here
            )
          : null,
      child: Row(
        children: [
          Checkbox(
              value: subtask.checked,
              onChanged: ((value) {
                subtasksAction.editCheck(index, value!);
              })),
          Expanded(
            child: Focus(
              onFocusChange: (value) {
                hasFocus.value = value;
                if (!value) {
                  subtasksAction.editText(index, controller.text);
                }
              },
              child: TextFormField(
                focusNode: focus,
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  subtasksAction.add(index);
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'subtask'),
                style: TextStyle(
                    decoration:
                        subtask.checked ? TextDecoration.lineThrough : null),
              ),
            ),
          ),
          hasFocus.value && !subtasksAction.onlyOneSubtask
              ? IconButton(
                  onPressed: () {
                    // hasFocus.value = false;
                    subtasksAction.remove(index);
                  },
                  icon: const Icon(Icons.clear_rounded))
              : const SizedBox(),
        ],
      ),
    );
  }
}
