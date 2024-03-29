import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/globals.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/extensions.dart';
import 'package:todo_list/services/notification_service.dart';

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

      final pendingNotifications =
          await NotificationService.pendingNotificationRequests();
      if (pendingNotifications.isNotEmpty) return;

      for (var i = 0; i < tasks.length; i++) {
        final task = tasks.elementAt(i);
        if (task.deadline == null) continue;
        final notificationId =
            await NotificationService.scheduleTaskNotification(task);
        tasks[i] = task.copyWith(notificationId: notificationId);
      }

      if (mounted) state = AsyncData(tasks);
    } catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

  Future<void> addTask(
      {required String title,
      DateTime? deadline,
      List<Subtask>? subtasks,
      required Priority priority,
      LatLng? position}) async {
    try {
      final tempTasks = state.value;
      state = const AsyncLoading();
      final task = Task(
          title: title,
          subtasks: subtasks,
          deadline: deadline,
          priority: priority,
          createdBy: _userId!,
          latitude: position?.latitude,
          longitude: position?.longitude);
      final taskId =
          await _ref.read(taskRepositoryProvider).addTask(task: task);

      int? notificationId;
      if (deadline != null) {
        notificationId =
            await NotificationService.scheduleTaskNotification(task);
      }

      state = AsyncData(tempTasks!
        ..add(task.copyWith(id: taskId, notificationId: notificationId)));
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

      if (updatedTask.deadline != null) {
        await NotificationService.scheduleTaskNotification(updatedTask);
      }

      log('[update] $updatedTask');
    } on Exception catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteTask({required String id, int? notificationId}) async {
    snackbarKey.showInfo(message: 'Loading...');
    try {
      final tempTasks = state.value;
      state = const AsyncLoading();
      await _ref.read(taskRepositoryProvider).deleteTask(id: id);
      state =
          AsyncData(tempTasks!.where((element) => element.id != id).toList());

      if (notificationId != null) {
        await NotificationService.cancelNotification(notificationId);
      }

      snackbarKey.show(message: 'Task deleted successfully');
    } on Exception catch (e, st) {
      log(e.toString());
      state = AsyncError(e, st);
    }
  }

  void setTasks(List<Task> newTasks) {
    state = AsyncData(newTasks);
  }
}
