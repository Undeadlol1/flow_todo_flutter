part of 'filtered_tasks_cubit.dart';

@freezed
class FilteredTasksState with _$FilteredTasksState {
  factory FilteredTasksState(List<Task> tasks) = _State;
}
