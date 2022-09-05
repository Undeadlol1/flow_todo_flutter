part of 'tasks_cubit.dart';

@unfreezed
class TasksState with _$TasksState {
  TasksState._();
  final List<Task> tasks = [];

  factory TasksState.loading() = _loading;
  factory TasksState.loaded(List<Task> tasks) = _loaded;

  factory TasksState.fromJson(Map<String, Object?> json) =>
      _$TasksStateFromJson(json);
}
