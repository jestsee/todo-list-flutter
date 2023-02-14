import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/ui/screens/add_task/add_task.dart';
import 'package:todo_list/ui/screens/index.dart';

import 'bottom_nav_bar.dart';

class ScaffoldWrapper extends HookWidget {
  const ScaffoldWrapper({super.key, required this.child});
  final Widget child;

  final screens = const [Home(), AddTask()];

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      body: IndexedStack(index: currentIndex.value, children: screens),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded, size: 32),
        onPressed: () {
          showAddTaskDialog(context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: BottomNavBar(
          currentIndex: currentIndex.value,
          onTap: (value) => currentIndex.value = value,
        ),
      ),
    );
  }
}
