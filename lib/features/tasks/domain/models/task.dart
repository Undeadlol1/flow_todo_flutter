import '../entities/task_entity.dart';
import '../entities/task_history_entity.dart';

class Task implements TaskEntity {
  @override
  final String id;
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
  final String userId;
  @override
  final int createdAt;
  @override
  int? updatedAt;
  @override
  final List<String> tags;
  // TODO
  @override
  List<TaskHistoryEntity> history;
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

  // TODO add  automatic mapping.
  Map<String, Object?> toJson() {
    return {
      'id': 'id',
      'title': title,

      'note': note,

      'userId': userId,

      'isDone': isDone.toString(),

      'repetitionLevel': repetitionLevel.toString(),

      'dueAt': dueAt.toString(),
      'doneAt': doneAt.toString(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'tags': tags.toString(),
      //  TODO
      'history': [].toString(),
    };
  }

// TODO
  // Task.fromJson(Map<String, Object?> json)
  // : this(

  //     title: json['title']! as String,
  //   );
}
