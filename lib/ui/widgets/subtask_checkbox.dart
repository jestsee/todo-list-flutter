import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/provider.dart';

class SubtaskCheckbox extends HookConsumerWidget {
  // final Subtask subtask;
  final int index;
  const SubtaskCheckbox(
      {super.key,
      // required this.subtask,
      required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focus = useState(false);
    final subtask =
        ref.watch(subtaskListControllerProvider).elementAt(index).subtask;
    final controller = ref.watch(
        ref.watch(subtaskListControllerProvider).elementAt(index).controller);
    final subtasksAction = ref.read(subtaskListControllerProvider.notifier);

    return Row(
      children: [
        Checkbox(value: subtask.checked, onChanged: ((value) {})),
        Expanded(
          child: FocusScope(
            child: Focus(
              onFocusChange: (value) {
                focus.value = value;
                if (!value) {
                  subtasksAction.editSubtaskText(index, controller.text);
                }
              },
              child: TextFormField(
                autofocus: true,
                controller: controller,
                // textInputAction: TextInputAction.send,
                // maxLines: null,
                // keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                onFieldSubmitted: (value) {
                  subtasksAction.addSubtask(index);
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'subtask'),
              ),
            ),
          ),
        ),
        focus.value && !subtasksAction.onlyOneSubtask
            ? IconButton(
                onPressed: () {
                  subtasksAction.removeSubtask(index);
                },
                icon: const Icon(Icons.clear_rounded))
            : const SizedBox(),
      ],
    );
  }
}
