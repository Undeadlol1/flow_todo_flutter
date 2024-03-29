import 'package:flow_todo_flutter_2022/core/services/optional_milliseconds_to_datetime_property_converter.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/services/milliseconds_to_datetime_property_converter.dart';
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
    @MillisecondsToDateTimePropertyConverter() required DateTime dueAt,
    @MillisecondsToDateTimePropertyConverter() required DateTime createdAt,
    @JsonKey(name: 'name') required String title,
    @JsonKey(defaultValue: '') required String note,
    @JsonKey(defaultValue: []) required List<String> tags,
    @JsonKey(defaultValue: []) required List<TaskHistory> history,
    @OptionalMillisecondsToDateTimePropertyConverter() DateTime? doneAt,
    @OptionalMillisecondsToDateTimePropertyConverter() DateTime? updatedAt,
    int? repetitionLevel,
    @Default(false) bool isSelected,
  }) = _Task;

  const Task._();

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);

  static final _staleTaskDetector = GetIt.I<StaleTaskDetector>();

  bool get isStale => _staleTaskDetector.isStale(this);
}
