import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

import '../debouncer.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncer = Debouncer(milliseconds: 500);
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          hintText: 'Search',
          hintStyle: const TextStyle(fontSize: 18),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          suffixIcon: const Icon(Icons.search)),
      onChanged: (value) => debouncer.run(() {
        ref.read(taskListControllerProvider.notifier).fetchTasks(title: value);
      }),
    );
  }
}
