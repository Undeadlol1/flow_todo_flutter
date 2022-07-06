import '../models/task.dart';

class StaleTaskDetector {
  StaleTaskDetector();

  get now => DateTime.now();

  bool isTale(Task task) {
    final bool isTaskCreatedLongAgo =
        _differenceInDaysWithToday(task.createdAt) > 3;
    final bool isTaskReadyButNotWorkedOn =
        _differenceInDaysWithToday(task.dueAt) > 3;
    final bool hasTaskBeenUpdatedRecently = task.updatedAt == null
        ? false
        : _differenceInDaysWithToday(
              DateTime.fromMillisecondsSinceEpoch(
                task.updatedAt!,
              ),
            ) <
            5;

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
