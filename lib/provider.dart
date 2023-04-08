import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/controllers/contact_controller.dart';
import 'package:todo_list/controllers/location_controller.dart';
import 'package:todo_list/controllers/marker_controller.dart';
import 'package:todo_list/controllers/profile_controller.dart';
import 'package:todo_list/controllers/task_list_controller.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/task_sort_enum.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';
import 'package:todo_list/repositories/profile/profile_repository.dart';
import 'package:todo_list/repositories/task/task_repository.dart';
import 'package:todo_list/extensions.dart';

import 'controllers/subtask_list_controller.dart';
import 'model/profile.dart';
import 'model/subtask.dart';
import 'model/subtask_with_controller.dart';
import 'model/task.dart';

final supabase = Supabase.instance.client;

// authentication
final authRepositoryProvider =
    r.Provider<AuthRepository>((_) => const AuthRepository());

final authStateChangesProvider = r.StreamProvider<AuthState>(
    ((ref) => ref.watch(authRepositoryProvider).authStateChanges));

final authControllerProvider =
    r.StateNotifierProvider<AuthController, AsyncValue<AuthState?>>(
        (ref) => AuthController(ref)..appStarted());

// profile
final profileRepositoryProvider =
    r.Provider<ProfileRepository>(((ref) => ProfileRepository(supabase)));

final profileControllerProvider =
    r.StateNotifierProvider<ProfileController, r.AsyncValue<Profile>>(((ref) {
  final user = ref.watch(authControllerProvider).value?.session?.user;
  return ProfileController(ref, user?.id);
}));

// task
final taskRepositoryProvider =
    r.Provider<TaskRepository>(((_) => TaskRepository(supabase)));

final taskListControllerProvider =
    r.StateNotifierProvider<TaskListController, r.AsyncValue<List<Task>>>(
        (ref) {
  final user = ref.watch(authControllerProvider).value?.session?.user;
  return TaskListController(ref, user?.id);
});

// task filter & sort
final searchFilterProvider = r.StateProvider<String?>((_) => null);
final priorityFilterProvider = r.StateProvider<Priority?>((_) => null);
final dateFilterProvider = r.StateProvider<DateTime?>((_) => null);
final taskSortProvider =
    r.StateProvider<TaskSortEnum>((_) => TaskSortEnum.closestDeadline);

final filteredTasksProvider = r.Provider<List<Task>>(((ref) {
  final taskList = ref.watch(taskListControllerProvider);
  final searchFilter = ref.watch(searchFilterProvider);
  final priorityFilter = ref.watch(priorityFilterProvider);
  final dateFilter = ref.watch(dateFilterProvider);
  final sortType = ref.watch(taskSortProvider);
  return taskList.maybeWhen(
      data: (data) {
        List<Task> tempData = data;
        if (searchFilter != null) {
          tempData = tempData
              .where((item) => item.title.contains(searchFilter))
              .toList();
        }
        if (priorityFilter != null) {
          tempData = tempData
              .where((item) => item.priority == priorityFilter)
              .toList();
        }
        if (dateFilter != null) {
          tempData = tempData
              .where((item) =>
                  item.deadline != null &&
                  item.deadline!.isSameDate(dateFilter))
              .toList();
        }
        switch (sortType) {
          case TaskSortEnum.closestDeadline:
            tempData = List.from(tempData
              ..sort((a, b) => (a.deadline ?? DateTime(2999))
                  .compareTo(b.deadline ?? DateTime(2999))));
            break;
          case TaskSortEnum.furthestDeadline:
            tempData = List.from(tempData
              ..sort((a, b) => (b.deadline ?? DateTime(2999))
                  .compareTo(a.deadline ?? DateTime(2999))));
            break;
          case TaskSortEnum.highestPriority:
            tempData = List.from(tempData
              ..sort((a, b) => b.priority.index.compareTo(a.priority.index)));
            break;
          default:
            tempData = List.from(tempData
              ..sort((a, b) => a.priority.index.compareTo(b.priority.index)));
            break;
        }
        return tempData;
      },
      orElse: () => []);
}));

// subtask
final currentSubtasksProvider = r.Provider<List<Subtask>>((ref) => <Subtask>[]);

final subtaskListProvider = r.Provider.autoDispose<List<Subtask>>((ref) {
  final check = ref.watch(checkedListControllerProvider);
  final uncheck = ref.watch(uncheckedListControllerProvider);
  final sub = [
    ...check.map((e) => e.copyWith(text: e.controller.text)),
    ...uncheck.map((e) => e.copyWith(text: e.controller.text))
  ];
  return sub.map((e) => e.subtask).toList();
}, dependencies: [
  uncheckedListControllerProvider,
  checkedListControllerProvider
]);

final uncheckedListControllerProvider = r.StateNotifierProvider<
    UncheckedSubtaskController, List<SubtaskWithController>>((ref) {
  final current = ref.watch(currentSubtasksProvider);

  return UncheckedSubtaskController(ref,
      subtasks: current.where((item) => !item.checked).toList());
}, dependencies: [currentSubtasksProvider]);

final checkedListControllerProvider = r.StateNotifierProvider<
    CheckedSubtaskController, List<SubtaskWithController>>((ref) {
  final current = ref.watch(currentSubtasksProvider);

  return CheckedSubtaskController(ref,
      subtasks: current.where((item) => item.checked).toList());
}, dependencies: [currentSubtasksProvider]);

// location
final locationControllerProvider =
    r.StateNotifierProvider<LocationController, r.AsyncValue<LatLng?>>(
        (_) => LocationController()..determinePosition());

// marker location
final markerControllerProvider =
    r.StateNotifierProvider.family<MarkerController, Marker?, LatLng?>(
        (ref, arg) => MarkerController(arg));

// contact
final contactControllerProvider =
    r.StateNotifierProvider<ContactController, r.AsyncValue<List<Contact>?>>(
        (_) => ContactController());
