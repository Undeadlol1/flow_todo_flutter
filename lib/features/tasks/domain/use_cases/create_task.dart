import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';

class CreateTask {
  final TasksCubit tasksCubit;
  final CreateTaskRepository createTaskRepository;
  CreateTask({required this.createTaskRepository, required this.tasksCubit});

  Future<void> call({required String title, required String userId}) async {
    final taskToCreate = Task(
      // TODO test this.
      id: '1231323',
      title: title,
      // TODO test
      dueAt: 0,
      // TODO test
      isDone: false,
      userId: userId,
      // TODO
      createdAt: 0,
      history: [],
      tags: [],
    );

    return createTaskRepository(taskToCreate);
  }
}
