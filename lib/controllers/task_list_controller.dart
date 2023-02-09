import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';

class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref _ref;
  final String? _userId;

  TaskListController(this._ref, this._userId) : super(const AsyncLoading()) {
    fetchTasks();
  }

  Future<void> fetchTasks({bool isRefreshing = false}) async {
    if (isRefreshing) state = const AsyncLoading();
    try {
      final tasks =
          await _ref.read(taskRepositoryProvider).fetchTasks(userId: _userId!);
      if (mounted) state = AsyncData(tasks);
    } catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }
}
