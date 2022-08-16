import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TaskRewardCalculator {
  const TaskRewardCalculator();

  int call(Task task) {
    return (50 + DateTime.now().difference(task.createdAt).inDays) *
        (task.isSelected ? 2 : 1);
  }
}
