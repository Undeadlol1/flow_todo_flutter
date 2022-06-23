import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';

import '../../../common/domain/use_cases/go_to_main_page.dart';
import '../../../spaced_repetition/domain/entities/confidence.dart';
import '../../../spaced_repetition/domain/services/next_repetition_calculator.dart';
import '../../../users/domain/use_cases/add_points_to_viewer.dart';
import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

class MakeStepForwardOnTheTask {
  final TasksCubit tasksCubit;
  final GoToMainPage goToMainPage;
  final SnackbarService snackbarService;
  final AddPointsToViewer addPointsToViewer;
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  final UpdateTaskRepository updateTaskRepository;
  final NextRepetitionCalculator nextRepetitionCalculator;
  const MakeStepForwardOnTheTask({
    required this.tasksCubit,
    required this.goToMainPage,
    required this.snackbarService,
    required this.addPointsToViewer,
    required this.tasksDoneTodayCubit,
    required this.updateTaskRepository,
    required this.nextRepetitionCalculator,
  });

  Future<void> call({
    required Task task,
    required Confidence howBigWasTheStep,
    bool isTaskDone = false,
  }) async {
    final today = DateTime.now().millisecondsSinceEpoch;
    final pointsToAdd =
        _calculateAmountOfPointsToAdd(isTaskDone, howBigWasTheStep);
    final nextRepetition = nextRepetitionCalculator(
      task: task,
      confidence: howBigWasTheStep,
    );

    tasksCubit.removeTask(task);

    final updatedTask = task.copyWith(
      isDone: isTaskDone,
      dueAt: nextRepetition.dueAt,
      // TODO not tested
      updatedAt: today,
      repetitionLevel: nextRepetition.repetitionLevel,
      history: [
        ...task.history,
        // TODO date argument is not tested.
        TaskHistory(
          createdAt: today,
          actionType: isTaskDone
              ? TaskHistoryActionType.doneTask
              : howBigWasTheStep == Confidence.good
                  ? TaskHistoryActionType.leapForward
                  : TaskHistoryActionType.stepForward,
        ),
      ],
    );

    tasksDoneTodayCubit
        .update([updatedTask, ...tasksDoneTodayCubit.state.tasks]);

    try {
      await goToMainPage();
      await addPointsToViewer(pointsToAdd);
      await updateTaskRepository.call(updatedTask);
    } catch (error) {
      snackbarService.displaySnackbar(text: error.toString());

      tasksCubit.undo();
    }
  }

  int _calculateAmountOfPointsToAdd(
    bool isTaskDone,
    Confidence howBigWasTheStep,
  ) {
    return isTaskDone
        ? 50
        : howBigWasTheStep == Confidence.good
            ? 30
            : 20;
  }
}

        // TaskService.deactivateActiveTasks(tasks),
        // upsertTask({
        //   ...task,
        //   ...values,
        //   history: [...get(task, 'history', []), historyToAdd],
        // }),
        // createTaskLog({
        //   ...historyToAdd,
        //   taskId,
        //   userId,
        //   createdAt: Date.now(),
        // }),
        // ViewerController.rewardUserForWorkingOnATask({
        //   points,
        //   snackbarMessage,
        // }),
        // TaskService.activateNextTask({
        //   nextTaskId,
        //   currentTasks: tasks,
        // }),
        // updateDailyStreak({
        //   profile,
        //   userId,
        //   tasksDoneToday,
        // }),

  // function stepForward(confidence: Confidence, pointsToAdd?: number) {
  //   const nextRepetition = calculateNextRepetition(
  //     props.task,
  //     confidence,
  //   );
  //   props
  //     .updateTask({
  //       values: {
  //         isCurrent: false,
  //         ...nextRepetition,
  //       },
  //       history: {
  //         taskId: props.task.id,
  //         userId: props.task.userId,
  //         createdAt: Date.now(),
  //         // @ts-ignore
  //         actionType:
  //           confidence === 'normal' ? 'stepForward' : 'leapForward',
  //       },
  //       pointsToAdd: confidence === 'normal' ? 10 : 20,
  //       snackbarMessage: t('important to step forward'),
  //     })
  //     .then(() => {
  //       Snackbar.addToQueue(
  //         t('you will see task again in', {
  //           date: distanceBetweenDates(
  //             nextRepetition.dueAt,
  //             new Date(),
  //           ),
  //         }),
  //       );
  //     });
  // }
