import 'dart:developer';

import 'package:todo_list/model/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/custom_exception.dart';

class TaskRepository {
  final SupabaseClient supabase;
  const TaskRepository(this.supabase);

  Future<List<Task>> fetchTasks(
      {required String userId, String? title, int? count}) async {
    try {
      late dynamic tasks;
      if (count != null && title != null) {
        tasks = await supabase
            .from('task')
            .select('*, group(*)')
            .eq('created_by', userId)
            .like('title', '%$title%')
            .limit(count);
      } else if (count != null) {
        tasks = await supabase
            .from('task')
            .select('*, group(*)')
            .eq('created_by', userId)
            .limit(count);
      } else if (title != null && title.isNotEmpty) {
        tasks = await supabase
            .from('task')
            .select('*, group(*)')
            .eq('created_by', userId)
            .like('title', '%$title%');
      } else {
        tasks = await supabase
            .from('task')
            .select('*, group(*)')
            .eq('created_by', userId);
      }
      return List.from(tasks.map((item) => Task.fromJson(item)));
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  Future<String> addTask({required Task task}) async {
    try {
      final createdTask =
          await supabase.from('task').insert(task.toCleaned()).select('id');
      log('created task id: $createdTask');
      final taskId = createdTask as List;
      return taskId.first['id'];
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  Future<void> updateTask({required Task task}) async {
    try {
      await supabase.from('task').update({
        'title': task.title,
        'subtask': task.subtasks,
        'deadline': task.deadline
      }).match({'id': task.id});
    } on Exception catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
