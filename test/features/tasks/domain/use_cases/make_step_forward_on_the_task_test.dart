import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/repetition.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fakes/fake_get_todays_date.dart';
import '../../../../test_utilities/fixtures/profile_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';
import '../../../../test_utilities/mocks/mock_go_to_main_page.dart';
import '../../../../test_utilities/mocks/mock_go_to_task_page.dart';
import '../../../../test_utilities/mocks/mock_profile_cubit.dart';
import '../../../../test_utilities/mocks/mock_snackbar_service.dart';
import '../../../../test_utilities/mocks/mock_tasks_cubit.dart';
import '../../../../test_utilities/mocks/mock_tasks_done_today_cubit.dart';
import '../../../../test_utilities/mocks/mock_update_profile_repository.dart';
import '../../../../test_utilities/mocks/mock_update_task_repository.dart';

class _MockAddPointsToViewer extends Mock implements AddPointsToViewer {}

class _MockNextRepetitionCalculator extends Mock
    implements NextRepetitionCalculator {}

final _tasksCubit = TasksCubit();
final _mockTasksCubit = MockTasksCubit();
final _mockProfileCubit = MockProfileCubit();
final _mockGoToMainPage = MockGoToMainPage();
final _mockGoToTaskPage = MockGoToTaskPage();
final _fakeGetTodaysDate = FakeGetTodaysDate();
final _tasksDoneTodayCubit = TasksDoneTodayCubit();
final _mockSnackbarService = MockSnackbarService();
final _mockAddPointsToViewer = _MockAddPointsToViewer();
final _mockTasksDoneTodayCubit = MockTasksDoneTodayCubit();
final _mockUpdateTaskRepository = MockUpdateTaskRepository();
final _mockUpdateProfileRepository = MockUpdateProfileRepository();
final _mockNextRepetitionCalculator = _MockNextRepetitionCalculator();

void main() {
  setUp(() {
    reset(_mockGoToTaskPage);
    reset(_mockAddPointsToViewer);
    reset(_mockTasksCubit);
    reset(_mockTasksDoneTodayCubit);
    reset(_mockUpdateProfileRepository);

    when(() => _mockTasksDoneTodayCubit.update(any())).thenReturn(null);
    when(() => _mockTasksDoneTodayCubit.state)
        .thenReturn(TasksDoneTodayState.loaded([]));
    when(() => _mockProfileCubit.state)
        .thenReturn(const ProfileLoaded(profile: profileFixture));

    _tasksDoneTodayCubit.update([]);
  });

  setUpAll(() {
    registerFallbackValue(taskFixture);
    registerFallbackValue(Confidence.normal);
  });

  tearDownAll(() {
    _tasksCubit.close();
    _tasksDoneTodayCubit.close();
  });

  group('GIVEN MakeStepForwardOnTheTask', () {
    test(
      'WHEN something throws an error '
      'THEN snackbar is displayed',
      () async {
        const errorText = 'Something went wrong 123';
        void snackBarServiceCall() {
          _mockSnackbarService.displaySnackbar(text: 'Exception: $errorText');
        }

        when(snackBarServiceCall).thenAnswer((_) async {});
        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception(errorText));

        await _getUseCaseWithMockedStates()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(snackBarServiceCall).called(1);
      },
    );

    test(
      'WHEN something throws an error '
      'THEN states revert back updates',
      () async {
        const errorText = 'Something went wrong 123';

        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception(errorText));

        await _getUseCaseWithMockedStates()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(() => _mockTasksCubit.undo()).called(1);
        verify(() => _mockTasksDoneTodayCubit.undo()).called(1);
      },
    );

    test(
      'WHEN something throws an error '
      'THEN navigates back to task page',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception('An error'));

        await _getUseCaseWithMockedStates()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(() => _mockGoToTaskPage(task: taskFixture)).called(1);
      },
    );

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
      'THEN puts the task into tasks done today cubit',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        expect(_tasksDoneTodayCubit.state.tasks, hasLength(1));
      },
    );

    test(
      'WHEN called '
      'THEN removes task from state',
      () async {
        _tasksCubit.updateList([taskFixture, taskFixture2]);
        _mockTypicalCalls(amountOfPointsToVerify: 30);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        expect(_tasksCubit.state.tasks, hasLength(1));
      },
    );

    group('WHEN daily streak is achieved', () {
      setUpAll(() => registerFallbackValue(profileFixture));

      test('THEN updates daily streak', () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);
        final yesterday = DateTime.now()
            .subtract(const Duration(days: 1))
            .millisecondsSinceEpoch;
        final tasksDoneToday = [taskFixture, taskFixture, taskFixture];
        final profileWithAchievedStreak = profileFixture.copyWith(
          dailyStreak: DailyStreak(
            perDay: tasksDoneToday.length,
            id: '12312313',
            userId: 'userId123',
            startsAt: yesterday,
            createdAt: yesterday,
          ),
        );
        final shouldDailyStreakUpdate = profileWithAchievedStreak.dailyStreak
            .shouldUpdate(tasksDoneToday: tasksDoneToday.length);
        expect(shouldDailyStreakUpdate, isTrue);
        when(() => _mockUpdateProfileRepository(any()))
            .thenAnswer((_) async {});
        when(() => _mockProfileCubit.state)
            .thenReturn(ProfileLoaded(profile: profileWithAchievedStreak));
        when((() => _mockTasksDoneTodayCubit.state)).thenReturn(
          TasksDoneTodayState.loaded(
            tasksDoneToday,
          ),
        );

        await _getUseCaseWithMockedStates()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
        );

        final repositoryCall = verify(
          () => _mockUpdateProfileRepository(captureAny()),
        );
        repositoryCall.called(1);
        expect(
          (repositoryCall.captured.first as Profile).dailyStreak.updatedAt,
          equals(_fakeGetTodaysDate.returnedValue.millisecondsSinceEpoch),
        );
      });
    });
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
    tasksCubit: _tasksCubit,
    profileCubit: _mockProfileCubit,
    goToMainPage: _mockGoToMainPage,
    goToTaskPage: _mockGoToTaskPage,
    getTodaysDate: _fakeGetTodaysDate,
    snackbarService: _mockSnackbarService,
    addPointsToViewer: _mockAddPointsToViewer,
    tasksDoneTodayCubit: _tasksDoneTodayCubit,
    updateTaskRepository: _mockUpdateTaskRepository,
    updateProfileRepository: _mockUpdateProfileRepository,
    nextRepetitionCalculator: _mockNextRepetitionCalculator,
  );
}

MakeStepForwardOnTheTask _getUseCaseWithMockedStates() {
  return MakeStepForwardOnTheTask(
    tasksCubit: _mockTasksCubit,
    profileCubit: _mockProfileCubit,
    goToMainPage: _mockGoToMainPage,
    goToTaskPage: _mockGoToTaskPage,
    getTodaysDate: _fakeGetTodaysDate,
    snackbarService: _mockSnackbarService,
    addPointsToViewer: _mockAddPointsToViewer,
    tasksDoneTodayCubit: _mockTasksDoneTodayCubit,
    updateTaskRepository: _mockUpdateTaskRepository,
    updateProfileRepository: _mockUpdateProfileRepository,
    nextRepetitionCalculator: _mockNextRepetitionCalculator,
  );
}
