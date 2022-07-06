import 'package:flutter/cupertino.dart';
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
    required bool isDone,
    required String userId,
    @_MillisecondsToDateTimeConverter() required DateTime dueAt,
    @_MillisecondsToDateTimeConverter() required DateTime createdAt,
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

class _MillisecondsToDateTimeConverter implements JsonConverter<DateTime, int> {
  const _MillisecondsToDateTimeConverter();

  @override
  DateTime fromJson(int json) {
    debugPrint('fromJSON');
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime date) {
    debugPrint('toJSON');
    return date.millisecondsSinceEpoch;
  }
}
