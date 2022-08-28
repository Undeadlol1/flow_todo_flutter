import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskRewardCalculator {
  const TaskRewardCalculator();

  int call(Task task) {
    final taskPlusDaysSinceCreation =
        50 + DateTime.now().difference(task.createdAt).inDays;

    return (taskPlusDaysSinceCreation * (task.isSelected ? 2 : 1)) *
        (task.isStale ? 2 : 1);
  }
}
