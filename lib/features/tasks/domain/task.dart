import '../../common/domain/user_created_document.dart';

class Task implements UserCreatedDocument {
  final String id;
  String title;
  String? note;
  bool isDone;
  int? repetitionLevel;
  num dueAt;
  num? doneAt;
  final List<String>? tags;
  // final bool? isCurrent;
  // subtasks?: Subtask[];
  // history?: TaskHistory[];

  @override
  final String userId;

  @override
  final num createdAt;

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
