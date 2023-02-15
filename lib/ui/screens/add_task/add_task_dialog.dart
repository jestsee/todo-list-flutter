import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/subtask_checkbox.dart';
import 'package:todo_list/ui/widgets/subtask_list.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              initialValue: 'ahoi',
              style: Theme.of(context).textTheme.headline3,
              decoration: InputDecoration(
                  hintText: 'Task title',
                  border: InputBorder.none,
                  suffix: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO are u sure dont want to save?
                      },
                      icon: const Icon(Icons.clear_rounded, size: 28))),
            ),
            const SubtaskList()
          ],
        ),
      ),
    );
  }
}

void showAddTaskDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(a1),
          child: const AddTaskDialog());
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
