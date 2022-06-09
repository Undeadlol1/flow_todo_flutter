import '../../../common/domain/user_created_document.dart';
import 'task_history.dart';

class Task implements UserCreatedDocument {
  final String id;
  String title;
  String? note;
  bool isDone;
  int? repetitionLevel;
  int dueAt;
  int? doneAt;
  final List<String>? tags;
  // final bool? isCurrent;
  // subtasks?: Subtask[];
  List<TaskHistory> history;

  @override
  final String userId;

  @override
  final int createdAt;

  @override
  int? updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.dueAt,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    required this.history,
    this.note,
    this.tags,
    this.doneAt,
    this.updatedAt,
    this.repetitionLevel,
  });
}
