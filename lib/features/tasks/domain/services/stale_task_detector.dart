import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:injectable/injectable.dart';

import '../models/task.dart';

@lazySingleton
class StaleTaskDetector {
  final RemoteConfigCubit remoteConfigCubit;
  StaleTaskDetector({required this.remoteConfigCubit});

  get now => DateTime.now();

  bool isStale(Task task) {
    if (!remoteConfigCubit.state.isStaleDetectionEnabled) {
      return false;
    }

    final bool isTaskCreatedLongAgo =
        _differenceInDaysWithToday(task.createdAt) > 3;
    final bool isTaskReadyButNotWorkedOn =
        _differenceInDaysWithToday(task.dueAt) > 3;
    final bool hasTaskBeenUpdatedRecently = task.updatedAt == null
        ? false
        : _differenceInDaysWithToday(task.updatedAt!) < 5;

    if (hasTaskBeenUpdatedRecently) {
      return false;
    }

    if (isTaskCreatedLongAgo && task.history.isEmpty) {
      return true;
    }
    if (isTaskReadyButNotWorkedOn) {
      return true;
    }

    return false;
  }

  int _differenceInDaysWithToday(DateTime time) {
    return now.difference(time).inDays;
  }
}
