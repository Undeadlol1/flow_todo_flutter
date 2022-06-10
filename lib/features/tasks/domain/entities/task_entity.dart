import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';

import '../../../common/domain/user_created_document.dart';

class TaskEntity implements UserCreatedDocument {
  final String id;
  String title;
  String? note;
  bool isDone;
  int? repetitionLevel;
  int dueAt;
  int? doneAt;
  final List<String> tags;
  // final bool? isCurrent;
  // subtasks?: Subtask[];
  List<TaskHistory> history;

  @override
  final String userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  TaskEntity({
    required this.id,
    required this.title,
    required this.dueAt,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    required this.history,
    required this.tags,
    this.note,
    this.doneAt,
    this.updatedAt,
    this.repetitionLevel,
  });
}
