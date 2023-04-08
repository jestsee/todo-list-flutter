import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/search_bar.dart';
import 'package:todo_list/ui/widgets/task_filter.dart';
import 'package:todo_list/ui/widgets/task_list.dart';

class AllTask extends StatelessWidget {
  const AllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const [
              Expanded(child: SearchBar()),
              SizedBox(width: 8),
              TaskFilter()
            ],
          ),
          const SizedBox(height: 20),
          const TaskList(filtered: true)
        ],
      ),
    ));
  }
}
