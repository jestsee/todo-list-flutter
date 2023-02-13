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

  Future<void> fetchTasks({String? title, int? count}) async {
    try {
      state = const AsyncLoading();
      final tasks = await _ref
          .read(taskRepositoryProvider)
          .fetchTasks(userId: _userId!, title: title, count: count);
      if (mounted) state = AsyncData(tasks);
    } catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }
}
