import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';

import '../model/subtask.dart';

class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref _ref;
  final String? _userId;

  TaskListController(this._ref, this._userId) : super(const AsyncLoading()) {
    fetchTasks();
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

  Future<void> addTask({required String title, DateTime? deadline}) async {
    try {
      final tempTasks = state.value;
      state = const AsyncLoading();
      final task = Task(
          title: title,
          subtasks: prepareSubtasks(),
          deadline: deadline,
          createdBy: _userId!);
      final taskId = await _ref
          .read(taskRepositoryProvider)
          .addTask(userId: _userId!, task: task);
      state = AsyncData(tempTasks!..add(task.copyWith(id: taskId)));
    } on Exception catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

// TODO pindahin?
  List<Subtask> prepareSubtasks() {
    final check = _ref.read(checkedListControllerProvider.notifier);
    final uncheck = _ref.read(uncheckedListControllerProvider.notifier);

    // sync both checked and unchecked subtasks
    check.syncSubtasks();
    uncheck.syncSubtasks();

    // combine both subtasks
    return [...check.state, ...uncheck.state].map((e) => e.subtask).toList();
  }

// TODO kemungkinan ga dipake
  void setSubtasks(List<Subtask> subtasks) {
    final check = _ref.read(checkedListControllerProvider.notifier);
    final uncheck = _ref.read(uncheckedListControllerProvider.notifier);

    log('setsub called');

    final List<Subtask> checkedSubtasks = [];
    final List<Subtask> uncheckedSubtasks = [];

    for (var item in subtasks) {
      if (item.checked) {
        checkedSubtasks.add(item);
      } else {
        uncheckedSubtasks.add(item);
      }
    }
    check.set(checkedSubtasks);
    uncheck.set(uncheckedSubtasks);
  }
}
