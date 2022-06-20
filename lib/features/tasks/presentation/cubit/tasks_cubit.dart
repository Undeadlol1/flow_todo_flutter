import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksLoading());

  void update(List<Task> tasks) {
    emit(TasksUpdated(tasks: tasks));
  }

  void removeTask(Task task) {
    state.tasks.remove(task);
    update(state.tasks);
  }

  // @override
  // TasksState? fromJson(Map<String, dynamic> json) {
  //   return TasksUpdated(
  //     tasks: List.from(json['tasks']).map((e) => Task.fromJson(e)).toList(),
  //   );
  // }

  // @override
  // Map<String, dynamic>? toJson(TasksState state) {
  //   return {"tasks": state.tasks.map((e) => e.toJson()).toList().toString()};
  // }
}
