import 'package:bloc/bloc.dart';

import '../../domain/entities/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void update(List<Task> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }
}
