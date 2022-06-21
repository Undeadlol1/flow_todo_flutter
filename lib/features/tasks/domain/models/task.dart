import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/task_entity.dart';
import 'task_history.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
@Implements<TaskEntity>()
class Task with _$Task {
  @JsonSerializable(explicitToJson: true)
  const factory Task({
    required String id,
    required int dueAt,
    required bool isDone,
    required String userId,
    required int createdAt,
    @JsonKey(name: 'name') required String title,
    @JsonKey(defaultValue: '') required String note,
    @JsonKey(defaultValue: []) required List<String> tags,
    @JsonKey(defaultValue: []) required List<TaskHistory> history,
    int? doneAt,
    int? updatedAt,
    int? repetitionLevel,
  }) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}
