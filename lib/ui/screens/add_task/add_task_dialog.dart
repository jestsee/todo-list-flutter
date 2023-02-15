import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/badge.dart';
import 'package:todo_list/ui/widgets/constants.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';
import 'package:todo_list/ui/widgets/subtask_list.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  const SubtaskList(),
                  // TODO
                  const SizedBox(height: 8),
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Last updated by me at 11.06 PM'))
                ],
              ),
              Column(
                children: [
                  CustomButton(
                      full: true, onPressed: () {}, child: const Text('Save')),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.75, color: Colors.black45),
                      ), //add it here
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Chip(
                              backgroundColor:
                                  badgeColor[BadgeVariant.moderate],
                              label: const Text(
                                'Medium',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.group, size: 36)),
                          GestureDetector(
                              onTap: () {},
                              child:
                                  const Icon(Icons.calendar_month, size: 36)),
                          GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.location_on, size: 36)),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
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
