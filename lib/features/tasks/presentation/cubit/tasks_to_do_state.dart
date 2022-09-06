part of 'tasks_to_do_cubit.dart';

@unfreezed
class TasksToDoState with _$TasksToDoState {
  TasksToDoState._();
  final List<Task> tasks = [];

  factory TasksToDoState.loading() = _loading;
  factory TasksToDoState.loaded(List<Task> tasks) = _loaded;

  factory TasksToDoState.fromJson(Map<String, Object?> json) =>
      _$TasksToDoStateFromJson(json);
}
