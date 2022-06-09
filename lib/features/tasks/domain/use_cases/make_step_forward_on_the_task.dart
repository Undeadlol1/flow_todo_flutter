import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';

import '../entities/task.dart';

class MakeStepForwardOnTheTask {
  final TasksCubit tasksCubit;
  final UpdateTaskRepository updateTaskRepository;
  final NextRepetitionCalculator nextRepetitionCalculator;
  const MakeStepForwardOnTheTask({
    required this.updateTaskRepository,
    required this.nextRepetitionCalculator,
    required this.tasksCubit,
  });

  Future<void> call({
    required Task task,
    required Confidence howBigWasTheStep,
  }) async {
    final nextRepetition = nextRepetitionCalculator(
      task: task,
      confidence: howBigWasTheStep,
    );

    task.dueAt = nextRepetition.dueAt;
    task.repetitionLevel = nextRepetition.repetitionLevel;

    await updateTaskRepository.call(task);

    tasksCubit.state.tasks.removeWhere((i) => i.id == task.id);
    tasksCubit.update(tasksCubit.state.tasks);
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
