part of 'tasks_done_today_cubit.dart';

@freezed
class TasksDoneTodayState with _$TasksDoneTodayState {
  final List<Task> tasks = [];
  TasksDoneTodayState._();

  factory TasksDoneTodayState.loading() = _loading;
  factory TasksDoneTodayState.loaded(List<Task> tasks) = _loaded;
}
