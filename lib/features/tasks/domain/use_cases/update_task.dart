import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateTask {
  final TasksCubit tasksCubit;
  final FilteredTasksCubit filteredTasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  const UpdateTask({
    required this.tasksCubit,
    required this.filteredTasksCubit,
    required this.updateTaskRepository,
  });

  Future<void> call(Task updatedTask) async {
    final newTask = updatedTask.copyWith(updatedAt: DateTime.now());

    _updateFilteredTasksCubit(newTask);

    tasksCubit.updateTask(newTask);

    return updateTaskRepository(newTask);
  }

  void _updateFilteredTasksCubit(Task updatedTask) {
    final filteredTasks = filteredTasksCubit.state.tasks;
    if (filteredTasks.any((i) => i.id == updatedTask.id)) {
      final taskIndex = filteredTasks.indexWhere((i) => i.id == updatedTask.id);
      filteredTasks[taskIndex] = updatedTask;
      filteredTasksCubit.update(filteredTasks);
    }
  }
}
