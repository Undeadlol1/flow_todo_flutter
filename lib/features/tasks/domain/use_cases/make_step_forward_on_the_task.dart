import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:injectable/injectable.dart';

import '../../../common/domain/use_cases/go_to_main_page.dart';
import '../../../spaced_repetition/domain/entities/confidence.dart';
import '../../../spaced_repetition/domain/services/next_repetition_calculator.dart';
import '../../../users/domain/use_cases/add_points_to_viewer.dart';
import '../../data/update_task_repository.dart';
import '../../presentation/cubit/tasks_cubit.dart';
import '../models/task.dart';

@singleton
class MakeStepForwardOnTheTask {
  final TasksCubit tasksCubit;
  final ProfileCubit profileCubit;
  final GoToMainPage goToMainPage;
  final GoToTaskPage goToTaskPage;
  final GetTodaysDate getTodaysDate;
  final SnackbarService snackbarService;
  final AddPointsToViewer addPointsToViewer;
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  final UpdateTaskRepository updateTaskRepository;
  final UpdateProfileRepository updateProfileRepository;
  final NextRepetitionCalculator nextRepetitionCalculator;
  const MakeStepForwardOnTheTask({
    required this.tasksCubit,
    required this.profileCubit,
    required this.goToMainPage,
    required this.goToTaskPage,
    required this.getTodaysDate,
    required this.snackbarService,
    required this.addPointsToViewer,
    required this.tasksDoneTodayCubit,
    required this.updateTaskRepository,
    required this.updateProfileRepository,
    required this.nextRepetitionCalculator,
  });

  Future<void> call({
    required Task task,
    required Confidence howBigWasTheStep,
    bool isTaskDone = false,
  }) async {
    final Profile updatedProfile = _getUpdatedProfile();
    final Task updatedTask =
        _getUpdatedTask(task, isTaskDone, howBigWasTheStep);
    final pointsToAdd =
        _calculateAmountOfPointsToAdd(isTaskDone, howBigWasTheStep);

    tasksCubit.removeTask(task);
    tasksDoneTodayCubit
        .update([...tasksDoneTodayCubit.state.tasks, updatedTask]);

    try {
      await goToMainPage();
      await addPointsToViewer(pointsToAdd);
      await updateTaskRepository.call(updatedTask);
      if (_shouldDailyStreakBeUpdated()) {
        await updateProfileRepository(updatedProfile);
      }
    } catch (error) {
      snackbarService.displaySnackbar(text: error.toString());

      tasksCubit.undo();
      tasksDoneTodayCubit.undo();

      return goToTaskPage.call(task: task);
    }
  }

  Profile _getUpdatedProfile() {
    final profile = profileCubit.state.profile;
    final today = getTodaysDate().millisecondsSinceEpoch;

    // TODO undo fucntionality
    final updatedProfile = profile!
        .copyWith(dailyStreak: profile.dailyStreak.copyWith(updatedAt: today));
    return updatedProfile;
  }

  bool _shouldDailyStreakBeUpdated() {
    final profile = profileCubit.state.profile;
    final tasksDoneToday = tasksDoneTodayCubit.state.tasks.length;
    // TODO .isBroken check
    return profile?.dailyStreak.shouldUpdate(
          tasksDoneToday: tasksDoneToday,
        ) ??
        false;
  }

  Task _getUpdatedTask(
    Task task,
    bool isTaskDone,
    Confidence howBigWasTheStep,
  ) {
    final today = getTodaysDate().millisecondsSinceEpoch;
    final nextRepetition = nextRepetitionCalculator(
      task: task,
      confidence: howBigWasTheStep,
    );

    return task.copyWith(
      isDone: isTaskDone,
      doneAt: today,
      updatedAt: today,
      dueAt: nextRepetition.dueAt,
      repetitionLevel: nextRepetition.repetitionLevel,
      history: [
        ...task.history,
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
