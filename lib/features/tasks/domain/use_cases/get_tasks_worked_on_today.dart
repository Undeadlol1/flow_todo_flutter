import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_task_worked_on_today_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetTasksWorkedOnToday {
  final TasksWorkedOnTodayCubit tasksDoneTodayCubit;
  final UseCaseExceptionHandler exceptionHandler;
  final GetTasksWorkedOnTodayRepository getTasksDoneTodayRepository;
  const GetTasksWorkedOnToday({
    required this.tasksDoneTodayCubit,
    required this.exceptionHandler,
    required this.getTasksDoneTodayRepository,
  });

  Future<void> call({required String userId}) async {
    try {
      final tasks = await getTasksDoneTodayRepository(userId: userId);
      // TODO this logic needs to be tested.
      tasks.removeWhere((i) {
        if (i.history.isEmpty) {
          return true;
        }

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
    } catch (error, stack) {
      exceptionHandler.call(error, stack);
    }
  }
}
