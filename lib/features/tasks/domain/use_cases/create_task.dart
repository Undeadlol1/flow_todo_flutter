import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';

class CreateTask {
  final TasksCubit tasksCubit;
  final GetTodaysDate getTodaysDate;
  final UniqueIdGenerator uniqueIdGenerator;
  final CreateTaskRepository createTaskRepository;
  CreateTask({
    required this.getTodaysDate,
    required this.tasksCubit,
    required this.uniqueIdGenerator,
    required this.createTaskRepository,
  });

  Future<void> call({required String title, required String userId}) async {
    final taskToCreate = Task(
      title: title,
      isDone: false,
      userId: userId,
      history: [],
      tags: [],
      id: uniqueIdGenerator(),
      dueAt: getTodaysDate().millisecondsSinceEpoch,
      createdAt: getTodaysDate().millisecondsSinceEpoch,
    );

    tasksCubit.state.tasks.add(taskToCreate);
    tasksCubit.update(tasksCubit.state.tasks);

    return createTaskRepository(taskToCreate);
  }
}
