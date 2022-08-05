import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/task.dart';

part 'tasks_state.dart';

@singleton
class TasksCubit extends HydratedCubit<TasksState> with ReplayCubitMixin {
  TasksCubit() : super(TasksLoading());

  void updateList(List<Task> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }

  void setLoading() {
    emit(TasksLoading());
  }

  void removeTask(Task task) {
    state.tasks.remove(task);
    updateList(state.tasks);
  }

  @override
  TasksState fromJson(Map<String, dynamic> json) {
    return TasksUpdated(
      tasks: List.from(json['tasks']).map((e) => Task.fromJson(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(TasksState state) {
    return {"tasks": state.tasks.map((e) => e.toJson()).toList()};
  }

  void updateTask(Task updatedTask) {
    final taskIndex = state.tasks.indexWhere((i) => i.id == updatedTask.id);
    state.tasks[taskIndex] = updatedTask;
    updateList(state.tasks);
  }
}
