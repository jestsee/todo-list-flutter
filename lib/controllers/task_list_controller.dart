import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';

import '../model/subtask.dart';

class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref _ref;
  final String? _userId;

  TaskListController(this._ref, this._userId) : super(const AsyncLoading()) {
    if (_userId != null) fetchTasks();
  }

  Future<void> fetchTasks({String? title, int? count}) async {
    try {
      log('fetch tasks called');
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

  Future<void> addTask(
      {required String title,
      DateTime? deadline,
      List<Subtask>? subtasks}) async {
    try {
      final tempTasks = state.value;
      state = const AsyncLoading();
      final task = Task(
          title: title,
          subtasks: subtasks,
          deadline: deadline,
          createdBy: _userId!);
      final taskId =
          await _ref.read(taskRepositoryProvider).addTask(task: task);
      state = AsyncData(tempTasks!..add(task.copyWith(id: taskId)));
    } on Exception catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

  Future<void> updateTask({required Task updatedTask}) async {
    try {
      final tempTasks = state.value;
      state = const AsyncLoading();
      await _ref.read(taskRepositoryProvider).updateTask(task: updatedTask);
      state = AsyncData([
        for (final task in tempTasks!)
          task.id == updatedTask.id ? updatedTask : task
      ]);
    } on Exception catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }
}
