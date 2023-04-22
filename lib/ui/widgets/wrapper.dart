import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/all_task/all_task.dart';
import 'package:todo_list/ui/screens/contact/contact_screen.dart';
import 'package:todo_list/ui/screens/dummy.dart';
import 'package:todo_list/ui/screens/index.dart';
import 'package:todo_list/ui/screens/profile/profile.dart';

import 'bottom_nav_bar.dart';

class ScaffoldWrapper extends ConsumerWidget {
  const ScaffoldWrapper({super.key, required this.child});
  final Widget child;

  final screens = const [
    Home(),
    ContactScreen(),
    Dummy(),
    AllTask(),
    Profile()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(bottomNavigationBarIndex),
        children: screens,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded, size: 32),
        onPressed: () {
          showTaskDialog(context);
        },
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7,
        clipBehavior: Clip.antiAlias,
        child: BottomNavBar(),
      ),
    );
  }
}
