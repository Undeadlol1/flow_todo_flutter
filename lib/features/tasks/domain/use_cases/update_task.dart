import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filter_by_tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateTask {
  final FilterByTagsCubit tagsCubit;
  final TasksToDoCubit tasksCubit;
  final FilteredTasksCubit filteredTasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const UpdateTask({
    required this.tagsCubit,
    required this.tasksCubit,
    required this.filteredTasksCubit,
    required this.updateTaskRepository,
    required this.useCaseExceptionHandler,
  });

  Future<void> call(Task updatedTask) async {
    try {
      final newTask = updatedTask.copyWith(updatedAt: DateTime.now());

      _updateFilteredTasksCubit(newTask);

      tagsCubit.reset();

      tasksCubit.updateTask(newTask);

      return updateTaskRepository(newTask);
    } catch (error, stack) {
      useCaseExceptionHandler(error, stack);
      rethrow;
    }
  }

  void _updateFilteredTasksCubit(Task updatedTask) {
    final filteredTasks = [...filteredTasksCubit.state.tasks];
    if (filteredTasks.any((i) => i.id == updatedTask.id)) {
      final taskIndex = filteredTasks.indexWhere((i) => i.id == updatedTask.id);
      filteredTasks[taskIndex] = updatedTask;
      filteredTasksCubit.update(filteredTasks);
    }
  }
}
