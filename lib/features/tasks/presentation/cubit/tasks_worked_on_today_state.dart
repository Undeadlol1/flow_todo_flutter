part of 'tasks_worked_on_today_cubit.dart';

@freezed
class TasksWorkedOnTodayState with _$TasksDoneTodayState {
  final List<Task> tasks = [];
  TasksWorkedOnTodayState._();

  factory TasksWorkedOnTodayState.loading() = _loading;
  factory TasksWorkedOnTodayState.loaded(List<Task> tasks) = _loaded;
}
