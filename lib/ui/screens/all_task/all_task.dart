import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_list/ui/widgets/search_bar.dart';
import 'package:todo_list/ui/widgets/task_filter.dart';
import 'package:todo_list/ui/widgets/task_list.dart';
import 'package:todo_list/ui/widgets/task_sort.dart';

class AllTask extends HookWidget {
  const AllTask({super.key});

  @override
  Widget build(BuildContext context) {
    final showFab = useState(false);
    return Scaffold(
      floatingActionButton: showFab.value ? const TaskSort() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!showFab.value) showFab.value = true;
          } else if (notification.direction == ScrollDirection.reverse) {
            if (showFab.value) showFab.value = false;
          }
          return true;
        },
        child: NestedScrollView(
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
      ),
    );
  }
}
