import 'package:injectable/injectable.dart';

import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

@injectable
class ToggleTaskSelection {
  final TasksCubit tasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  const ToggleTaskSelection({
    required this.tasksCubit,
    required this.updateTaskRepository,
  });

  Future<void> call(Task task) async {
    final updatedTask = task.copyWith(
      isSelected: !task.isSelected,
    );

    tasksCubit.updateTask(updatedTask);

    return updateTaskRepository(updatedTask);
  }
}
