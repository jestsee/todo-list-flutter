import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/controllers/task_list_controller.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';
import 'package:todo_list/repositories/task/task_repository.dart';

import 'controllers/check_uncheck_subtask_controller.dart';
import 'model/subtask_with_controller.dart';
import 'model/task.dart';

final supabase = Supabase.instance.client;

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
    r.Provider<TaskRepository>(((_) => TaskRepository(supabase)));

final taskListControllerProvider =
    r.StateNotifierProvider<TaskListController, r.AsyncValue<List<Task>>>(
        (ref) {
  final user = ref.watch(authRepositoryProvider).getCurrentUser;
  return TaskListController(ref, user?.id);
});

// subtask
final uncheckedListControllerProvider = r.StateNotifierProvider.autoDispose<
        UncheckedSubtaskController, List<SubtaskWithController>>(
    (ref) => UncheckedSubtaskController(ref)..add(-1));

final checkedListControllerProvider = r.StateNotifierProvider.autoDispose<
    CheckedSubtaskController,
    List<SubtaskWithController>>((ref) => CheckedSubtaskController(ref));
