import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../domain/models/task.dart';

part 'tasks_state.dart';
part 'tasks_cubit.g.dart';
part 'tasks_cubit.freezed.dart';

@singleton
class TasksCubit extends HydratedCubit<TasksState> with ReplayCubitMixin {
  TasksCubit() : super(TasksState.loading());

  void updateList(List<Task> tasks) {
    emit(TasksState.loaded(tasks));
  }

  void setLoading() {
    emit(TasksState.loading());
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
  Map<String, dynamic> toJson(TasksState state) => state.toJson();
  @override
  TasksState fromJson(Map<String, dynamic> json) => TasksState.fromJson(json);
}
