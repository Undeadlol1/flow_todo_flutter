import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

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
