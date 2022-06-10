import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';
import 'package:json_annotation/json_annotation.dart';

import '../entities/task_entity.dart';

part 'task.g.dart';

@JsonSerializable()
class Task implements TaskEntity {
  @override
  final String id, userId;
  @override
  String title;
  @override
  String? note;
  @override
  bool isDone;
  @override
  int? repetitionLevel;
  @override
  int dueAt;
  @override
  int? doneAt;
  @override
  final int createdAt;
  @override
  int? updatedAt;
  @override
  final List<String> tags;
  @override
  List<TaskHistory> history;
  // final bool? isCurrent;
  // subtasks?: Subtask[];

  Task({
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

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
