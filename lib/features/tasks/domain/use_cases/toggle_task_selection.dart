import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

@injectable
class ToggleTaskSelection {
  final TasksCubit tasksCubit;
  final FirebaseAnalytics firebaseAnalytics;
  final UpdateTaskRepository updateTaskRepository;
  const ToggleTaskSelection({
    required this.tasksCubit,
    required this.firebaseAnalytics,
    required this.updateTaskRepository,
  });

  Future<void> call(Task task) async {
    final updatedTask = task.copyWith(
      isSelected: !task.isSelected,
    );

    tasksCubit.updateTask(updatedTask);

    await updateTaskRepository(updatedTask);

    return firebaseAnalytics.logEvent(
      name: updatedTask.isSelected ? "selected_task" : "deselected_task",
    );
  }
}
