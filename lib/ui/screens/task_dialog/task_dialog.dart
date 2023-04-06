import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/subtask.dart';
import 'package:todo_list/model/task.dart';
import 'package:todo_list/provider.dart';
import 'package:todo_list/ui/screens/map_dialog/map_dialog.dart';
import 'package:todo_list/ui/widgets/custom_button.dart';
import 'package:todo_list/ui/widgets/priority_chip.dart';
import 'package:todo_list/ui/widgets/subtask_list.dart';
import 'package:todo_list/extensions.dart';

class TaskDialog extends HookWidget {
  final Task? task;
  const TaskDialog({super.key, this.task});

  bool get isUpdate => task?.id != null;

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: task?.title);
    final date = useState<DateTime?>(task?.deadline);
    final time = useState<TimeOfDay?>(task?.deadline != null
        ? TimeOfDay.fromDateTime(task!.deadline!)
        : null);
    final priority = useState<Priority>(task?.priority ?? Priority.low);
    final subtasks = useState(task?.subtasks ?? List<Subtask>.empty());
    final location = useState<LatLng?>(task?.latitude != null
        ? LatLng(task!.latitude!, task!.longitude!)
        : null);

    void handlePriority() {
      priority.value = priority.value.switchPriority();
    }

    DateTime? getMergedTime() => date.value
        ?.copyWith(hour: time.value?.hour, minute: time.value?.minute);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: ProviderScope(
          overrides: [
            currentSubtasksProvider.overrideWithValue(subtasks.value)
          ],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputDecorator(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffix: IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 28),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )),
                child: TextFormField(
                  controller: titleController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: Theme.of(context).textTheme.headline3,
                  decoration:
                      const InputDecoration.collapsed(hintText: 'Task title'),
                ),
              ),
              const SubtaskList(),
              const SizedBox(height: 16),
              // TODO
              // const Align(
              //     alignment: Alignment.bottomRight,
              //     child: Text('Last updated by me at 11.06 PM')),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final currentTasks = ref.watch(taskListControllerProvider);
                  ref.listen(
                    taskListControllerProvider,
                    (previous, next) {
                      if (next.hasValue) {
                        Navigator.of(context).pop();
                      }
                    },
                  );

                  return CustomButton(
                    full: true,
                    loading: currentTasks.isLoading,
                    onPressed: () {
                      final position = ref
                          .watch(markerControllerProvider(location.value))
                          ?.position;

                      final subtasks = ref.read(subtaskListProvider);
                      final taskAction =
                          ref.read(taskListControllerProvider.notifier);
                      isUpdate
                          ? taskAction.updateTask(
                              updatedTask: task!.copyWith(
                                  title: titleController.text,
                                  deadline: getMergedTime(),
                                  subtasks: subtasks,
                                  priority: priority.value,
                                  latitude: position?.latitude,
                                  longitude: position?.longitude))
                          : taskAction.addTask(
                              title: titleController.text,
                              deadline: getMergedTime(),
                              subtasks: subtasks,
                              priority: priority.value,
                              position: position);

                      ref.invalidate(markerControllerProvider);
                      ref.invalidate(uncheckedListControllerProvider);
                      ref.invalidate(checkedListControllerProvider);
                    },
                    child: Text(isUpdate ? 'Update' : 'Save'),
                  );
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.75, color: Colors.black45),
                  ), //add it here
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: PriorityChip(
                            priority: priority.value,
                            onPressed: handlePriority,
                            selected: true),
                      ),
                      GestureDetector(
                        child: const Icon(Icons.calendar_month, size: 36),
                        onTap: () async {
                          date.value = await showDatePicker(
                            context: context,
                            initialDate:
                                task?.deadline ?? date.value ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2099),
                          );
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.access_time, size: 36),
                        onTap: () async {
                          time.value = await showTimePicker(
                              context: context,
                              initialTime: time.value ?? TimeOfDay.now());
                        },
                      ),
                      GestureDetector(
                        child: const Icon(Icons.location_on, size: 36),
                        onTap: () {
                          showMapDialog(context,
                              initialLocation: location.value,
                              markerLocation: location.value);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showTaskDialog(BuildContext context, {Task? task}) {
  showGeneralDialog(
    context: context,
    pageBuilder: (ctx, a1, a2) {
      return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(a1),
          child: TaskDialog(task: task));
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
