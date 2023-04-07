import 'package:flutter/material.dart';
import 'package:todo_list/ui/widgets/search_bar.dart';
import 'package:todo_list/ui/widgets/task_filter.dart';
import 'package:todo_list/ui/widgets/task_list.dart';
import 'package:todo_list/ui/widgets/task_sort.dart';

class AllTask extends StatelessWidget {
  const AllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const TaskSort(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Tasks',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              floating: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: Row(
                    children: const [
                      Expanded(child: SearchBar()),
                      SizedBox(width: 12),
                      TaskFilter()
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: TaskList(filtered: true),
        ),
      ),
    );
  }
}
