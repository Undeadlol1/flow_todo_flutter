import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  void update(List<Task> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }
}
