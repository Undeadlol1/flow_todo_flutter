import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

@injectable
class ToggleTaskSelection {
  final TasksCubit tasksCubit;
  final FirebaseAnalytics firebaseAnalytics;
  final FirebaseRemoteConfig firebaseRemoteConfig;
  final UpdateTaskRepository updateTaskRepository;
  const ToggleTaskSelection({
    required this.tasksCubit,
    required this.firebaseAnalytics,
    required this.firebaseRemoteConfig,
    required this.updateTaskRepository,
  });

  // TODO revisit this logic.
  Future<void> call(Task task) async {
    if (firebaseRemoteConfig.getBool('is_only_single_selected_task_allowed') &&
        !(task.isSelected) &&
        tasksCubit.state.tasks.isNotEmpty) {
      return;
    }

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
