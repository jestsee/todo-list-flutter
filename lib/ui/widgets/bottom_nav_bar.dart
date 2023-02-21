import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex, this.onTap});
  final int currentIndex;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.checklist_rounded), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ]);
  }
}
