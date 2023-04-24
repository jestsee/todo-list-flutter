import 'package:faker/faker.dart';
import 'package:todo_list/model/priority.dart';
import 'package:todo_list/model/task.dart';

import '../model/subtask.dart';

class FakerService {
  static final _faker = Faker();

  static Task generateTask(String createdBy) {
    return Task(
      id: _faker.guid.guid(),
      title: _faker.food.cuisine(),
      createdBy: createdBy,
      priority: _faker.randomGenerator.element(Priority.values),
      subtasks: List.generate(3, (_) => generateSubtask()),
    );
  }

  static Subtask generateSubtask() {
    return Subtask(
      text: _faker.food.dish(),
      checked: _faker.randomGenerator.boolean(),
    );
  }

  static List<Task> generateBulkTasks(String createdBy, int length) {
    return List.generate(length, (_) => generateTask(createdBy));
  }
}
