import 'package:todo_list/model/priority.dart';

class TaskFilter {
  final String? query;
  final Priority? priority;
  final DateTime? date;

  TaskFilter({this.query, this.priority, this.date});
}
