import '../../common/domain/user_created_document.dart';

class Task implements UserCreatedDocument {
  final String id;
  final String title;
  final String? note;
  final bool isDone;
  final int? repetitionLevel;
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
    required this.title,
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
