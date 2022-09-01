import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:injectable/injectable.dart';

import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

@injectable
class ToggleTaskSelection {
  final TasksCubit tasksCubit;
  final FirebaseAnalytics firebaseAnalytics;
  final RemoteConfigCubit remoteConfigCubit;
  final UpdateTaskRepository updateTaskRepository;
  const ToggleTaskSelection({
    required this.tasksCubit,
    required this.firebaseAnalytics,
    required this.remoteConfigCubit,
    required this.updateTaskRepository,
  });

  Future<void> call(Task task) async {
    if (_isOperationDissalowed(task)) {
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

  bool _isOperationDissalowed(Task task) {
    final isOnlyASingleSelectedTaskAllowed =
        remoteConfigCubit.state.isOnlyASingleSelectedTaskAllowed;
    final isATaskAlreadySelected =
        tasksCubit.state.tasks.any((i) => i.isSelected && i.id != task.id);

    return isOnlyASingleSelectedTaskAllowed && isATaskAlreadySelected;
  }
}
