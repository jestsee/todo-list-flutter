import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/search_bar.dart';
import 'package:todo_list/ui/widgets/task_list.dart';

class AllTask extends StatelessWidget {
  const AllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const <Widget>[SearchBar(), TaskList()],
    ));
  }
}