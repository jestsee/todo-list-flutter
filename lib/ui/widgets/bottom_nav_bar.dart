import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex, this.onTap});
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: onTap,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Group',
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
