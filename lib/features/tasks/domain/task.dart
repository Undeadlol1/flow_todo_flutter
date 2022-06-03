class Task {
  final String id;
  final String userId;
  final String? note;
  final bool isDOne;
  final num? repetitionLevel;
  final List<String>? tags;
  final num dueAt;
  final num? doneAt;
  final num createdAt;
  final num? updatedAt;
  // final bool? isCurrent;
  // subtasks?: Subtask[];
  // history?: TaskHistory[];

  Task({
    required this.id,
    required this.dueAt,
    required this.userId,
    required this.isDOne,
    required this.createdAt,
    this.note,
    this.tags,
    this.doneAt,
    this.updatedAt,
    this.repetitionLevel,
  });
}
