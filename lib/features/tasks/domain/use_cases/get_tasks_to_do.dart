import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:injectable/injectable.dart';

import '../models/task.dart';

@singleton
class GetTasksToDo {
  final TasksCubit tasksCubit;
  final GetTasksToDoRepository getTasks;
  final UseCaseExceptionHandler exceptionHandler;
  GetTasksToDo({
    required this.getTasks,
    required this.tasksCubit,
    required this.exceptionHandler,
  });

  Future<void> call({required String userId}) async {
    await getTasks(userId: userId)
        .then(_updateStateIfNecessary)
        .catchError(exceptionHandler);
  }

  void _updateStateIfNecessary(List<Task> remoteTasks) {
    if (_cachedTasksAreNotEqualToRemotetasks(remoteTasks)) {
      remoteTasks.shuffle();
      tasksCubit.updateList(remoteTasks);
    }
  }

  bool _cachedTasksAreNotEqualToRemotetasks(List<Task> remoteTasks) {
    final localTasks = tasksCubit.state.tasks;

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
