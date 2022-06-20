import 'package:replay_bloc/replay_bloc.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> with ReplayCubitMixin {
  TasksCubit() : super(TasksLoading());

  void updateList(List<Task> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }

  void removeTask(Task task) {
    state.tasks.remove(task);
    updateList(state.tasks);
  }
}
