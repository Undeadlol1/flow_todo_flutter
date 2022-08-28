import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskRewardCalculator {
  const TaskRewardCalculator();

  int taskCompletion(Task task) {
    final completionRewardPlusDaysSinceCreation =
        50 + DateTime.now().difference(task.createdAt).inDays;

    return _addMultiplicationBonuses(
      completionRewardPlusDaysSinceCreation,
      task,
    );
  }

  int stepForward(Task task) => _addMultiplicationBonuses(20, task);

  int leapForward(Task task) => _addMultiplicationBonuses(30, task);

  int _addMultiplicationBonuses(int rewardAmountBase, Task task) {
    return (rewardAmountBase * (task.isSelected ? 2 : 1)) *
        (task.isStale ? 2 : 1);
  }
}
