import 'dart:developer';

import 'package:todo_list/model/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/custom_exception.dart';

class TaskRepository {
  const TaskRepository();

// TODO fetch berdasarkan id user yang sedang login
  Future<List<Task>> fetchTasks() async {
    try {
      final tasks = await Supabase.instance.client.from('task').select();
      log('hahh $tasks');
      return List.from(tasks.map((item) => Task.fromJson(item)));
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
