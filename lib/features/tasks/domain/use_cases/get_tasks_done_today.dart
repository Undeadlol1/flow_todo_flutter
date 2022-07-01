import 'package:flow_todo_flutter_2022/features/tasks/data/get_task_done_today_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTasksDoneToday {
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  final GetTasksDoneTodayRepository getTasksDoneTodayRepository;
  const GetTasksDoneToday({
    required this.tasksDoneTodayCubit,
    required this.getTasksDoneTodayRepository,
  });

  Future<void> call({required String userId}) async {
    final tasks = await getTasksDoneTodayRepository(userId: userId);
    // TODO this logic needs to be tested.
    tasks.removeWhere((i) {
      // TODO test/fix history order;
      switch (i.history.last.actionType) {
        case TaskHistoryActionType.doneTask:
          return false;
        case TaskHistoryActionType.doneSubtask:
          return false;
        case TaskHistoryActionType.stepForward:
          return false;
        case TaskHistoryActionType.leapForward:
          return false;
        default:
          return true;
      }
    });
    tasksDoneTodayCubit.update(tasks.reversed.toList());
  }
}
