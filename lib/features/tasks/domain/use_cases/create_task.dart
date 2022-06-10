import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';

class CreateTask {
  final TasksCubit tasksCubit;
  final CreateTaskRepository createTaskRepository;
  CreateTask({required this.createTaskRepository, required this.tasksCubit});

  void call() {
    // final taskToCreate = Task(
    // id: id,
    // title: title,
    // dueAt: dueAt,
    // isDone: isDone,
    // // TODO
    // userId: userId,
    // createdAt: createdAt,
    // history: [],
    // tags: [],);
  }
}
