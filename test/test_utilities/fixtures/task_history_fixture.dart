import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';

final taskHistoryFixture = TaskHistory(
  actionType: TaskHistoryActionType.addSubtask,
  createdAt: DateTime.now().millisecondsSinceEpoch,
);
