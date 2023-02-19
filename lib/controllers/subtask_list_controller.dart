import 'package:todo_list/controllers/base_subtask_controller.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/provider.dart';

class UncheckedSubtaskController extends BaseSubtaskController {
  UncheckedSubtaskController(super.ref, {List<Subtask>? subtasks})
      : super(subtasks: subtasks);

  @override
  void editCheck(int idx) {
    syncSubtasks();
    final checkSubtask = ref.read(checkedListControllerProvider.notifier);
    checkSubtask.add(checkSubtask.length - 1,
        subtask: state[idx].subtask.copyWith(checked: true));
    remove(idx);
  }
}

class CheckedSubtaskController extends BaseSubtaskController {
  CheckedSubtaskController(super.ref, {List<Subtask>? subtasks})
      : super(checked: true, subtasks: subtasks);

  @override
  void editCheck(int idx) {
    syncSubtasks();
    final uncheckSubtask = ref.read(uncheckedListControllerProvider.notifier);
    uncheckSubtask.add(uncheckSubtask.length - 1,
        subtask: state[idx].subtask.copyWith(checked: false));
    remove(idx);
  }
}
