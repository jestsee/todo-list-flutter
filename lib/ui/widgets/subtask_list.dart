import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/subtask_checkbox.dart';

class SubtaskList extends ConsumerWidget {
  const SubtaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unchecked = ref.watch(uncheckedListControllerProvider);
    final uncheckedAction = ref.read(uncheckedListControllerProvider.notifier);
    final checked = ref.watch(checkedListControllerProvider);

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: unchecked.length,
          itemBuilder: (BuildContext context, int index) {
            return SubtaskCheckbox(
              uncheckedListControllerProvider,
              index: index,
            );
          },
        ),
        GestureDetector(
          child: const ListTile(
            leading: Icon(Icons.add, size: 24),
            title: Text('New subtask'),
            textColor: Colors.grey,
          ),
          onTap: () {
            uncheckedAction.add(unchecked.length - 1);
          },
        ),
        unchecked.isNotEmpty && checked.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.25, color: Colors.black45),
                    ), //add it here
                  ),
                ),
              )
            : const SizedBox(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: checked.length,
          itemBuilder: (BuildContext context, int index) {
            return SubtaskCheckbox(
              checkedListControllerProvider,
              index: index,
            );
          },
        )
      ],
    );
  }
}
