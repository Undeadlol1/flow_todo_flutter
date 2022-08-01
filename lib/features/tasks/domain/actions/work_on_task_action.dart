import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';

class WorkOnTaskAction {
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  const WorkOnTaskAction({required this.tasksDoneTodayCubit});

  void call(Task task) {
    updateState(task);
  }

  void updateState(Task task) {
    if (_taskWasNotAddedToCubitBefore(task)) {
      tasksDoneTodayCubit.update([...tasksDoneTodayCubit.state.tasks, task]);
    }
  }

  void undoState() {
    tasksDoneTodayCubit.undo();
  }

  bool _taskWasNotAddedToCubitBefore(Task task) {
    return !tasksDoneTodayCubit.state.tasks.any((i) => i.id == task.id);
  }
}
