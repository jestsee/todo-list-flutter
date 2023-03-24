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
        data: (data) => data.isNotEmpty ? data.length : 'no',
        error: (err, st) => '',
        loading: () => '...');
    const gap = 8.0;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${(ref.watch(authRepositoryProvider).getCurrentUser!.userMetadata)!['name']}!',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: gap - 4),
            Text('You have $tasksLength unfinished tasks'),
            const SizedBox(height: 3 * gap),
            const SearchBar(),
            const SizedBox(height: 3 * gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Task', style: Theme.of(context).textTheme.headline3),
                TextButton(
                  child: const Text('See all',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  onPressed: () {},
                )
              ],
            ),
            const TaskList(),
            // CustomButton(
            //     full: true,
            //     onPressed: () {
            //       ref.read(authControllerProvider.notifier).signOut();
            //     },
            //     child: const Text('Sign out'))
          ],
        ),
      ),
    );
  }
}
