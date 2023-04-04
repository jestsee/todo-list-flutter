import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/ui/screens/all_task/all_task.dart';
import 'package:todo_list/ui/screens/index.dart';
import 'package:todo_list/ui/screens/profile/profile.dart';

import 'bottom_nav_bar.dart';

class ScaffoldWrapper extends HookWidget {
  const ScaffoldWrapper({super.key, required this.child});
  final Widget child;

  final screens = const [Home(), AllTask(), AllTask(), Profile()];

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    return Scaffold(
      body: IndexedStack(index: currentIndex.value, children: screens),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded, size: 32),
        onPressed: () {
          showTaskDialog(context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        clipBehavior: Clip.antiAlias,
        child: BottomNavBar(
          currentIndex: currentIndex.value,
          onTap: (value) => currentIndex.value = value,
        ),
      ),
    );
  }
}
