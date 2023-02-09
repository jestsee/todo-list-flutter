import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/controllers/task_list_controller.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';
import 'package:todo_list/repositories/task/task_repository.dart';

import 'model/task.dart';

// authentication
final authRepositoryProvider =
    r.Provider<AuthRepository>((_) => const AuthRepository());

final authStateChangesProvider = r.StreamProvider<AuthState>(
    ((ref) => ref.watch(authRepositoryProvider).authStateChanges));

final authControllerProvider =
    r.StateNotifierProvider<AuthController, UserState>(
        (ref) => AuthController(ref)..appStarted());

// task
final taskRepositoryProvider =
    r.Provider<TaskRepository>(((ref) => const TaskRepository()));

final taskListControllerProvider =
    r.StateNotifierProvider<TaskListController, r.AsyncValue<List<Task>>>(
        (ref) {
  return TaskListController(ref, '1');
});
