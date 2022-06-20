import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/repetition.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/entities/task_history_action_type.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';
import '../../../../test_utilities/mocks/mock_snackbar_service.dart';

class _MockGoToMainPage extends Mock implements GoToMainPage {}

class _MockAddPointsToViewer extends Mock implements AddPointsToViewer {}

class _MockUpdateTaskRepository extends Mock implements UpdateTaskRepository {}

class _MockNextRepetitionCalculator extends Mock
    implements NextRepetitionCalculator {}

final _tasksCubit = TasksCubit();
final _mockGoToMainPage = _MockGoToMainPage();
final _tasksDoneTodayCubit = TasksDoneTodayCubit();
final _mockSnackbarService = MockSnackbarService();
final _mockAddPointsToViewer = _MockAddPointsToViewer();
final _mockUpdateTaskRepository = _MockUpdateTaskRepository();
final _mockNextRepetitionCalculator = _MockNextRepetitionCalculator();

void main() {
  setUp(() {
    reset(_mockAddPointsToViewer);
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
      'WHEN soemthing throws an error '
      'THEN snackbar is displayed',
      () async {
        const errorText = 'Something went wrong 123';
        void snackBarServiceCall() {
          _mockSnackbarService.displaySnackbar(text: 'Exception: $errorText');
        }

        _mockTypicalCalls(amountOfPointsToVerify: 20);
        when(snackBarServiceCall).thenAnswer((_) async {});
        when(() => _mockUpdateTaskRepository(any()))
            .thenThrow(Exception(errorText));

        await _getUseCase()(
          task: taskFixture,
          isTaskDone: false,
          howBigWasTheStep: Confidence.normal,
        );

        verify(snackBarServiceCall).called(1);
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

  final repositoryTaskArgument =
      (verify(() => _mockUpdateTaskRepository(captureAny())).captured[0]
          as Task);
  expect(repositoryTaskArgument.isDone, isTaskMarkedAsDone);
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
    goToMainPage: _mockGoToMainPage,
    snackbarService: _mockSnackbarService,
    addPointsToViewer: _mockAddPointsToViewer,
    tasksDoneTodayCubit: _tasksDoneTodayCubit,
    updateTaskRepository: _mockUpdateTaskRepository,
    nextRepetitionCalculator: _mockNextRepetitionCalculator,
  );
}
