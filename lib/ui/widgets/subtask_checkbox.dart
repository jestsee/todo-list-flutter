import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/base_subtask_controller.dart';
import 'package:todo_list/model/subtask_with_controller.dart';

class SubtaskCheckbox extends HookConsumerWidget {
  final int index;
  final AutoDisposeStateNotifierProvider<BaseSubtaskController,
      List<SubtaskWithController>> subtaskListControllerProvider;
  const SubtaskCheckbox(this.subtaskListControllerProvider,
      {super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subtasksAction = ref.read(subtaskListControllerProvider.notifier);
    final subtaskProvider = ref.watch(subtaskListControllerProvider)[index];
    final subtask = subtaskProvider.subtask;
    final controller = subtaskProvider.controller;
    final focus = subtaskProvider.focus;

    final hasFocus = useState(false);

    return Row(
      children: [
        Checkbox(
            value: subtask.checked,
            onChanged: ((_) {
              subtasksAction.editCheck(index);
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
              decoration: const InputDecoration.collapsed(hintText: 'subtask'),
              style: TextStyle(
                  decoration:
                      subtask.checked ? TextDecoration.lineThrough : null),
            ),
          ),
        ),
        hasFocus.value
            ? IconButton(
                onPressed: () {
                  // hasFocus.value = false;
                  subtasksAction.remove(index);
                },
                icon: const Icon(Icons.clear_rounded))
            : const SizedBox(),
      ],
    );
  }
}
