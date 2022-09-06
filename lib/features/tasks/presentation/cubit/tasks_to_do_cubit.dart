import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/task.dart';

part 'tasks_to_do_state.dart';
part 'tasks_to_do_cubit.g.dart';
part 'tasks_to_do_cubit.freezed.dart';

@singleton
class TasksToDoCubit extends HydratedCubit<TasksToDoState>
    with ReplayCubitMixin {
  TasksToDoCubit() : super(TasksToDoState.loading());

  void updateList(List<Task> tasks) {
    emit(TasksToDoState.loaded(tasks));
  }

  void setLoading() {
    emit(TasksToDoState.loading());
  }

  void removeTask(Task task) {
    updateList([...state.tasks]..remove(task));
  }

  void updateTask(Task updatedTask) {
    final tasksCopy = [...state.tasks];
    final taskIndex = tasksCopy.indexWhere((i) => i.id == updatedTask.id);
    tasksCopy[taskIndex] = updatedTask;
    updateList(tasksCopy);
  }

  @override
  Map<String, dynamic> toJson(TasksToDoState state) => state.toJson();
  @override
  TasksToDoState fromJson(Map<String, dynamic> json) =>
      TasksToDoState.fromJson(json);
}
