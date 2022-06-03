import 'package:flow_todo_flutter_2022/features/common/domain/user_created_document.dart';

class Task implements UserCreatedDocument {
  final String id;
  final String? note;
  final bool isDone;
  final num? repetitionLevel;
  final List<String>? tags;
  final num dueAt;
  final num? doneAt;
  // final bool? isCurrent;
  // subtasks?: Subtask[];
  // history?: TaskHistory[];

  @override
  String userId;

  @override
  num createdAt;

  @override
  num? updatedAt;

  Task({
    required this.id,
    required this.dueAt,
    required this.isDone,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
    this.note,
    this.tags,
    this.doneAt,
    this.repetitionLevel,
  });
}
