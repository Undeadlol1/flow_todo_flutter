import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

import '../models/task.dart';

@singleton
class UpdateTaskNote {
  final TasksCubit tasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  const UpdateTaskNote({
    required this.tasksCubit,
    required this.updateTaskRepository,
  });

  Future<void> call({required Task task, required String note}) async {
    final updatedTask = task.copyWith(note: note);

    tasksCubit.updateTask(updatedTask);

    return updateTaskRepository(updatedTask);
  }
}
