import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/repetition.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/use_cases/increment_daily_streak_action.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/actions/work_on_task_action.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fakes/fake_get_todays_date.dart';
import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_go_to_main_page.dart';
import '../../../../test_utilities/mocks/mock_go_to_task_page.dart';
import '../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../test_utilities/mocks/mock_snackbar_service.dart';
import '../../../../test_utilities/mocks/mock_tasks_cubit.dart';
import '../../../../test_utilities/mocks/mock_tasks_worked_on_today_cubit.dart';
import '../../../../test_utilities/mocks/mock_upsert_profile_repository.dart';
import '../../../../test_utilities/mocks/mock_update_task_repository.dart';

class _MockAddPointsToViewer extends Mock implements AddPointsToViewer {}

class _MockIncrementDailyStreak extends Mock
    implements IncrementDailyStreakAction {}

class _MockWorkOnTaskAction extends Mock implements WorkOnTaskAction {}

class _MockNextRepetitionCalculator extends Mock
    implements NextRepetitionCalculator {}

class _MockTasksWorkedOnTodayCubit extends Mock
    implements TasksWorkedOnTodayCubit {}

final _mockTasksCubit = MockTasksCubit();
final _mockProfileCubit = MockProfileCubit();
final _mockGoToMainPage = MockGoToMainPage();
final _mockGoToTaskPage = MockGoToTaskPage();
final _fakeGetTodaysDate = FakeGetTodaysDate();
final _mockSnackbarService = MockSnackbarService();
final _mockWorkOnTaskAction = _MockWorkOnTaskAction();
final _mockAddPointsToViewer = _MockAddPointsToViewer();
final _mockTasksDoneTodayCubit = MockTasksWorkedOnTodayCubit();
final _mockUpdateTaskRepository = MockUpdateTaskRepository();
final _mockTasksWorkedOnTodayCubit = _MockTasksWorkedOnTodayCubit();
final _mockUpdateProfileRepository = MockUpsertProfileRepository();
final _mockNextRepetitionCalculator = _MockNextRepetitionCalculator();
final IncrementDailyStreakAction _mockIncrementDailyStreak =
    _MockIncrementDailyStreak();

void main() {
  setUpAll(() {
    registerFallbackValue(taskFixture);
    registerFallbackValue(Confidence.normal);

    whenListen(
      _mockTasksWorkedOnTodayCubit,
      Stream.fromIterable([TasksWorkedOnTodayState.loaded([])]),
      initialState: TasksWorkedOnTodayState.loaded([]),
    );
  });

  setUp(() {
    reset(_mockTasksCubit);
    reset(_mockGoToTaskPage);
    reset(_mockWorkOnTaskAction);
    reset(_mockAddPointsToViewer);
    reset(_mockTasksDoneTodayCubit);
    reset(_mockIncrementDailyStreak);
    reset(_mockUpdateProfileRepository);

    when(() => _mockTasksDoneTodayCubit.update(any())).thenReturn(null);
    when(() => _mockTasksDoneTodayCubit.state)
        .thenReturn(TasksWorkedOnTodayState.loaded([]));
    when(() => _mockProfileCubit.state)
        .thenReturn(ProfileLoaded(profile: profileFixture));
  });

  group('GIVEN MakeStepForwardOnTheTask', () {
    group('WHEN something throws an error', () {
      test('THEN snackbar is displayed', () async {
        const errorText = 'Something went wrong 123';
        void snackBarServiceCall() {
          _mockSnackbarService.displaySnackbar(text: 'Exception: $errorText');
        }

        when(snackBarServiceCall).thenAnswer((_) async {});
        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception(errorText));

        await _getUseCase()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(snackBarServiceCall).called(1);
      });

      test('THEN states revert back updates', () async {
        const errorText = 'Something went wrong 123';

        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception(errorText));

        await _getUseCase()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(() => _mockTasksCubit.undo()).called(1);
        verify(() => _mockWorkOnTaskAction.undoState()).called(1);
      });

      test('THEN navigates back to task page', () async {
        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception('An error'));

        await _getUseCase()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(() => _mockGoToTaskPage(task: taskFixture)).called(1);
      });
    });

    test(
      'WHEN isDone argument is false '
      'THEN task is not set as done via repository',
      () async {
        return _verifyAndReturnUpdateTaskRepositoryArgument(
          isTaskMarkedAsDone: false,
        );
      },
    );

    test(
      'WHEN isDone argument is true '
      'THEN task is set as done via repository',
      () async {
        final taskPassedToRepository =
            await _verifyAndReturnUpdateTaskRepositoryArgument(
          isTaskMarkedAsDone: true,
        );
        _verifyThatProperHistoryWasAddedToTask(
          task: taskPassedToRepository,
          actionType: TaskHistoryActionType.doneTask,
        );
      },
    );

    test(
      'WHEN confidence is normal '
      'THEN adds task history with proper action type to task via repository',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 20);

        final taskPassedToRepository =
            await _verifyAndReturnUpdateTaskRepositoryArgument(
          isTaskMarkedAsDone: false,
          confidence: Confidence.normal,
        );

        _verifyThatProperHistoryWasAddedToTask(
          task: taskPassedToRepository,
          actionType: TaskHistoryActionType.stepForward,
        );
      },
    );

    test(
      'WHEN confidence is good '
      'THEN adds task history with proper action type to task via repository',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        final taskPassedToRepository =
            await _verifyAndReturnUpdateTaskRepositoryArgument(
          isTaskMarkedAsDone: false,
          confidence: Confidence.good,
        );

        _verifyThatProperHistoryWasAddedToTask(
          task: taskPassedToRepository,
          actionType: TaskHistoryActionType.leapForward,
        );
      },
    );

    test(
      'WHEN task is set as done '
      'THEN then rewards 50 points',
      _verifyPointsRewarded(
        isTaskDone: true,
        confidence: Confidence.good,
        amountOfPointsToVerify: 50,
      ),
    );

    test(
      'WHEN confidence is normal '
      'THEN then rewards 20 points',
      _verifyPointsRewarded(
        amountOfPointsToVerify: 20,
        confidence: Confidence.normal,
      ),
    );

    test(
      'WHEN confidence is good '
      'THEN then rewards 30 points',
      _verifyPointsRewarded(
        amountOfPointsToVerify: 30,
        confidence: Confidence.good,
      ),
    );

    test(
      'WHEN called '
      'THEN calls WorkOnTaskAction',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        verify(() => _mockWorkOnTaskAction.updateState(taskFixture)).called(1);
      },
    );

    test(
      'WHEN called '
      'THEN removes task from state',
      () async {
        void callTaskRemoverMethod() => _mockTasksCubit.removeTask(taskFixture);
        when(callTaskRemoverMethod).thenReturn(null);
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        verify(callTaskRemoverMethod).called(1);
      },
    );

    test(
      'WHEN called THEN calls IncrementStreak service',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        verify(() => _mockIncrementDailyStreak()).called(1);
      },
    );
  });
}

void _verifyThatProperHistoryWasAddedToTask({
  required Task task,
  required TaskHistoryActionType actionType,
}) {
  expect(task.history, hasLength(1));
  expect(task.history.first.actionType, actionType);
}

Future<void> Function() _verifyPointsRewarded({
  required int amountOfPointsToVerify,
  bool isTaskDone = false,
  Confidence confidence = Confidence.good,
}) {
  return () async {
    _mockTypicalCalls(amountOfPointsToVerify: amountOfPointsToVerify);

    await _getUseCase()(
      task: taskFixture,
      isTaskDone: isTaskDone,
      howBigWasTheStep: confidence,
    );

    verify(() => _mockAddPointsToViewer(amountOfPointsToVerify)).called(1);
  };
}

Future<Task> _verifyAndReturnUpdateTaskRepositoryArgument({
  required bool isTaskMarkedAsDone,
  Confidence confidence = Confidence.good,
}) async {
  _mockTypicalCalls(amountOfPointsToVerify: isTaskMarkedAsDone ? 50 : 30);

  await _getUseCase()(
    task: taskFixture,
    isTaskDone: isTaskMarkedAsDone,
    howBigWasTheStep: confidence,
  );

  final dateToVerify = _fakeGetTodaysDate.returnedValue.millisecondsSinceEpoch;
  final repositoryTaskArgument =
      (verify(() => _mockUpdateTaskRepository(captureAny())).captured[0]
          as Task);
  expect(repositoryTaskArgument.isDone, isTaskMarkedAsDone);
  expect(repositoryTaskArgument.updatedAt, dateToVerify);
  if (isTaskMarkedAsDone) {
    expect(repositoryTaskArgument.doneAt, dateToVerify);
  }
  expect(repositoryTaskArgument.history, hasLength(1));

  return repositoryTaskArgument;
}

void _mockTypicalCalls({required int amountOfPointsToVerify}) {
  when(() => _mockGoToMainPage()).thenAnswer((_) async {});
  when(() => _mockWorkOnTaskAction.updateState(taskFixture)).thenReturn(null);
  when(() => _mockIncrementDailyStreak()).thenAnswer((_) async {});
  when(() => _mockUpdateTaskRepository(any())).thenAnswer((_) async {});
  when(() => _mockAddPointsToViewer(amountOfPointsToVerify))
      .thenAnswer((_) async {});
  when(
    () => _mockNextRepetitionCalculator(
      task: taskFixture,
      confidence: any(named: 'confidence'),
    ),
  ).thenReturn(Repetition(dueAt: 0, repetitionLevel: 1));
}

MakeStepForwardOnTheTask _getUseCase() {
  return MakeStepForwardOnTheTask(
    tasksCubit: _mockTasksCubit,
    profileCubit: _mockProfileCubit,
    goToMainPage: _mockGoToMainPage,
    goToTaskPage: _mockGoToTaskPage,
    getTodaysDate: _fakeGetTodaysDate,
    snackbarService: _mockSnackbarService,
    updateTask: _mockUpdateTaskRepository,
    workOnTaskAction: _mockWorkOnTaskAction,
    addPointsToViewer: _mockAddPointsToViewer,
    tasksDoneTodayCubit: _mockTasksWorkedOnTodayCubit,
    updateProfile: _mockUpdateProfileRepository,
    incrementDailyStreak: _mockIncrementDailyStreak,
    nextRepetitionCalculator: _mockNextRepetitionCalculator,
  );
}
