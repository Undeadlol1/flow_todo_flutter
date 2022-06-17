import 'task_history_action_type.dart';

class TaskHistoryEntity {
  final String? taskId;
  final String? comment;
  final TaskHistoryActionType actionType;

  final String? userId;

  final int createdAt;

  int? updatedAt;

  TaskHistoryEntity({
    required this.createdAt,
    required this.actionType,
    this.taskId,
    this.userId,
    this.comment,
  });
}
