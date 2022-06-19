import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_history.freezed.dart';
part 'task_history.g.dart';

@freezed
@Implements<TaskHistoryEntity>()
class TaskHistory with _$TaskHistory {
  // https://stackoverflow.com/a/71516177
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory TaskHistory({
    required TaskHistoryActionType actionType,
    required int createdAt,
    String? taskId,
    String? userId,
    String? comment,
    int? updatedAt,
  }) = _TaskHistory;

  factory TaskHistory.fromJson(Map<String, Object?> json) =>
      _$TaskHistoryFromJson(json);
}
