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
  final AddPointsToViewer addPointsToViewer;
  final UpdateTaskRepository updateTaskRepository;
  final NextRepetitionCalculator nextRepetitionCalculator;
  const MakeStepForwardOnTheTask({
    required this.tasksCubit,
    required this.goToMainPage,
    required this.addPointsToViewer,
    required this.updateTaskRepository,
    required this.nextRepetitionCalculator,
  });

  Future<void> call({
    required Task task,
    required Confidence howBigWasTheStep,
    bool isTaskDone = false,
  }) async {
    final nextRepetition = nextRepetitionCalculator(
      task: task,
      confidence: howBigWasTheStep,
    );

    task.isDone = isTaskDone;
    task.dueAt = nextRepetition.dueAt;
    task.repetitionLevel = nextRepetition.repetitionLevel;

    tasksCubit.state.tasks.removeWhere((i) => i.id == task.id);
    tasksCubit.update(tasksCubit.state.tasks);

    await goToMainPage();
    await addPointsToViewer(howBigWasTheStep == Confidence.good ? 30 : 20);
    await updateTaskRepository.call(task);
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
