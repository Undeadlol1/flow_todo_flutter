import 'package:bloc/bloc.dart';

import '../../domain/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void update(List<Task> updatedTasks) {
    emit(TasksUpdated(tasks: updatedTasks));
  }
}