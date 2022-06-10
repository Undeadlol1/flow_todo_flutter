import 'package:bloc/bloc.dart';

import '../../domain/entities/task_entity.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void update(List<TaskEntity> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }
}
