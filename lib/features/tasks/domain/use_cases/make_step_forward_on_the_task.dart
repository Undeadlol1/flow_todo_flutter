import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/use_cases/increment_daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task_history.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:timeago/timeago.dart' as relativetime;

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
  final UpdateTaskRepository updateTask;
  final AddPointsToViewer addPointsToViewer;
  final UpsertProfileRepository updateProfile;
  final TasksDoneTodayCubit tasksDoneTodayCubit;
  final IncrementDailyStreak incrementDailyStreak;
  final NextRepetitionCalculator nextRepetitionCalculator;
  const MakeStepForwardOnTheTask({
    required this.tasksCubit,
    required this.updateTask,
    required this.profileCubit,
    required this.goToMainPage,
    required this.goToTaskPage,
    required this.getTodaysDate,
    required this.updateProfile,
    required this.snackbarService,
    required this.addPointsToViewer,
    required this.tasksDoneTodayCubit,
    required this.incrementDailyStreak,
    required this.nextRepetitionCalculator,
  });

  Future<void> call({
    required Task task,
    required Confidence howBigWasTheStep,
    bool isTaskDone = false,
  }) async {
    tasksCubit.removeTask(task);
    tasksDoneTodayCubit.update([...tasksDoneTodayCubit.state.tasks, task]);
    profileCubit.setProfile(_getUpdatedProfile());

    try {
      final updatedTask = _getUpdatedTask(task, isTaskDone, howBigWasTheStep);
      final pointsToAdd = _getAmountOfPointsToAdd(isTaskDone, howBigWasTheStep);

      _displaySnackbar(isTaskDone, updatedTask);
      await goToMainPage();
      await updateTask(updatedTask);
      await addPointsToViewer(pointsToAdd);
      await incrementDailyStreak();
    } catch (error) {
      return _handleErrors(error: error, task: task);
    }
  }

  void _handleErrors({required Object error, required Task task}) {
    snackbarService.displaySnackbar(text: error.toString());

    tasksCubit.undo();
    profileCubit.undo();
    tasksDoneTodayCubit.undo();

    return goToTaskPage.call(task: task);
  }

  Profile _getUpdatedProfile() {
    final today = getTodaysDate();
    final streak = profileCubit.state.profile!.dailyStreak;
    final tasksDoneToday = tasksDoneTodayCubit.state.tasks.length;

    final updatedProfile = profileCubit.state.profile!.copyWith(
      dailyStreak: streak.copyWith(
        startsAt: streak.isInterrupted() ? today : streak.startsAt,
        updatedAt: streak.shouldStreakIncrement(tasksDoneToday: tasksDoneToday)
            ? today.millisecondsSinceEpoch
            : streak.updatedAt,
      ),
    );

    return updatedProfile;
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
      updatedAt: today,
      isDone: isTaskDone,
      doneAt: isTaskDone ? today : null,
      dueAt: DateTime.fromMillisecondsSinceEpoch(nextRepetition.dueAt),
      repetitionLevel: nextRepetition.repetitionLevel,
      history: [
        TaskHistory(
          createdAt: today,
          actionType: isTaskDone
              ? TaskHistoryActionType.doneTask
              : howBigWasTheStep == Confidence.good
                  ? TaskHistoryActionType.leapForward
                  : TaskHistoryActionType.stepForward,
        ),
        ...task.history,
      ],
    );
  }

  int _getAmountOfPointsToAdd(
    bool isTaskDone,
    Confidence howBigWasTheStep,
  ) {
    return isTaskDone
        ? 50
        : howBigWasTheStep == Confidence.good
            ? 30
            : 20;
  }

  void _displaySnackbar(bool isTaskDone, Task updatedTask) {
    if (isTaskDone == false) {
      snackbarService.displaySnackbar(
        text: _getNumberOfDaysForNextIterationText(updatedTask),
      );
    }
  }

  String _getNumberOfDaysForNextIterationText(Task updatedTask) {
    return 'You will see this task again in ${relativetime.format(
      updatedTask.dueAt,
      allowFromNow: true,
    )}';
  }
}
