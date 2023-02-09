import 'dart:developer';

import 'package:todo_list/model/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/repositories/custom_exception.dart';

class TaskRepository {
  final SupabaseClient supabase;
  const TaskRepository(this.supabase);

// TODO fetch berdasarkan id user yang sedang login
  Future<List<Task>> fetchTasks({required String userId}) async {
    try {
      final tasks =
          await supabase.from('task').select().eq('created_by', userId);
      log('hahh $tasks');
      return List.from(tasks.map((item) => Task.fromJson(item)));
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
