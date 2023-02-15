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
    final subtask = ref.watch(subtaskListControllerProvider)[index].subtask;
    final controller =
        ref.watch(subtaskListControllerProvider)[index].controller;
    final focus = ref.watch(subtaskListControllerProvider)[index].focus;

    final hasFocus = useState(false);

    return Row(
      children: [
        Checkbox(value: subtask.checked, onChanged: ((value) {})),
        Expanded(
          child: Focus(
            onFocusChange: (value) {
              hasFocus.value = value;
              if (!value) {
                subtasksAction.editSubtaskText(index, controller.text);
              }
            },
            child: TextFormField(
              focusNode: focus,
              controller: controller,
              // textInputAction: TextInputAction.send,
              // maxLines: null,
              // keyboardType: TextInputType.multiline,
              onChanged: (value) {},
              onFieldSubmitted: (value) {
                subtasksAction.addSubtask(index);
              },
              decoration: const InputDecoration.collapsed(hintText: 'subtask'),
            ),
          ),
        ),
        hasFocus.value && !subtasksAction.onlyOneSubtask
            ? IconButton(
                onPressed: () {
                  // hasFocus.value = false;
                  subtasksAction.removeSubtask(index);
                },
                icon: const Icon(Icons.clear_rounded))
            : const SizedBox(),
      ],
    );
  }
}
