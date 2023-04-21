import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/task_sort_enum.dart';
import 'package:todo_list/provider.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationBarIndex);
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (value) {
          if (value == 0) {
            ref.read(priorityFilterProvider.notifier).state = null;
            ref.read(dateFilterProvider.notifier).state = null;
            ref.read(searchFilterProvider.notifier).state = '';
            ref.read(taskSortProvider.notifier).state =
                TaskSortEnum.closestDeadline;
          }
          ref.read(bottomNavigationBarIndex.notifier).state = value;
        },
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Contact',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: SizedBox(
                width: 40,
              ),
              label: 'Dummy',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rounded),
              label: 'Task',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.black),
        ]);
  }
}
