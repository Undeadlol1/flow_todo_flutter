part of 'selected_tasks_cubit.dart';

@freezed
class SelectedTasksState with _$SelectedTasksState {
  const factory SelectedTasksState(List<Task> tasks) = _State;
}
