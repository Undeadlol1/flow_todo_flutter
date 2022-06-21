import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';

import '../models/task.dart';

class UpdateTaskNote {
  final TasksCubit tasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  const UpdateTaskNote({
    required this.tasksCubit,
    required this.updateTaskRepository,
  });

  Future<void> call({required Task task, required String note}) async {
    final updatedTask = task.copyWith(note: note);

    _updateTaskInCubit(currentTask: task, updatedTask: updatedTask);

    return updateTaskRepository(task.copyWith(note: note));
  }

  void _updateTaskInCubit({
    required Task currentTask,
    required Task updatedTask,
  }) {
    final cubitTasks = tasksCubit.state.tasks;
    final taskIndex = cubitTasks.indexWhere((i) => i.id == currentTask.id);
    cubitTasks[taskIndex] = updatedTask;
    tasksCubit.updateList(cubitTasks);
  }
}
