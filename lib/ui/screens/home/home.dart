import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/widgets/search_bar.dart';
import 'package:todo_list/ui/widgets/task_list.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksLength = ref.watch(taskListControllerProvider).when(
        data: (data) => data.isNotEmpty
            ? 'You have ${data.length} tasks'
            : 'All tasks done!',
        error: (err, st) => 'Something went wrong',
        loading: () => 'Loading...');
    const gap = 6.0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.watch(profileControllerProvider).when(
                    loading: (() => 'Loading...'),
                    data: (data) => 'Hi, ${data.name}',
                    error: (error, stackTrace) => 'Something went wrong',
                  ),
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: gap - 4),
            Text(tasksLength, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 3 * gap),
            const SearchBar(),
            const SizedBox(height: 3 * gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Task', style: Theme.of(context).textTheme.displayMedium),
                TextButton(
                  child: const Text('See all',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  onPressed: () {
                    ref.read(bottomNavigationBarIndex.notifier).state = 3;
                  },
                )
              ],
            ),
            const Expanded(child: TaskList(addPadding: false, pick: 2)),
          ],
        ),
      ),
    );
  }
}
