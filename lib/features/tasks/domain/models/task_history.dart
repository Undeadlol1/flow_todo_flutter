import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_history.g.dart';

@JsonSerializable()
class TaskHistory implements TaskHistoryEntity {
  @override
  int? updatedAt;

  @override
  final TaskHistoryActionType actionType;

  @override
  String? comment;

  @override
  final int createdAt;

  @override
  String? taskId;

  @override
  String? userId;

  TaskHistory({
    required this.actionType,
    required this.createdAt,
    this.taskId,
    this.userId,
    this.comment,
    this.updatedAt,
  });

  factory TaskHistory.fromJson(Map<String, dynamic> json) => _$TaskHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$TaskHistoryToJson(this);
}
