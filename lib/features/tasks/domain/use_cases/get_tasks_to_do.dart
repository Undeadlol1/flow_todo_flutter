import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

import '../models/task.dart';

@singleton
class GetTasksToDo {
  final TasksCubit tasksCubit;
  final GetTasksToDoRepository getTasks;
  GetTasksToDo({required this.getTasks, required this.tasksCubit});

  Future<void> call({required String userId}) async {
    if (tasksCubit.state is! TasksUpdated) {
      tasksCubit.setLoading();
    }

    final remoteTasks = await getTasks(userId: userId);

    _updateStateIfNecessary(remoteTasks);
  }

  void _updateStateIfNecessary(List<Task> remoteTasks) {
    if (_cachedTasksAreNotEqualToRemotetasks(
      remoteTasks: remoteTasks,
      localTasks: tasksCubit.state.tasks,
    )) {
      remoteTasks.shuffle();
      tasksCubit.updateList(remoteTasks);
    }
  }

  bool _cachedTasksAreNotEqualToRemotetasks({
    required List<Task> remoteTasks,
    required List<Task> localTasks,
  }) {
    if (remoteTasks.length != localTasks.length) {
      return true;
    }

    final areLocalTasksNotEqualToRemote = remoteTasks.any((remoteTask) {
      try {
        final localTask = localTasks.firstWhere((i) => i.id == remoteTask.id);
        return localTask != remoteTask;
      } catch (e) {
        return true;
      }
    });

    return areLocalTasksNotEqualToRemote;
  }
}
