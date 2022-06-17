import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/repetition.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';

class _MockGoToMainPage extends Mock implements GoToMainPage {}

class _MockAddPointsToViewer extends Mock implements AddPointsToViewer {}

class _MockUpdateTaskRepository extends Mock implements UpdateTaskRepository {}

class _MockNextRepetitionCalculator extends Mock
    implements NextRepetitionCalculator {}

final _tasksCubit = TasksCubit();
final _mockGoToMainPage = _MockGoToMainPage();
final _tasksDoneTodayCubit = TasksDoneTodayCubit();
final _mockAddPointsToViewer = _MockAddPointsToViewer();
final _mockUpdateTaskRepository = _MockUpdateTaskRepository();
final _mockNextRepetitionCalculator = _MockNextRepetitionCalculator();

void main() {
  setUp(() => reset(_mockAddPointsToViewer));

  tearDownAll(() {
    _tasksCubit.close();
    _tasksDoneTodayCubit.close();
  });

  group('GIVEN MakeStepForwardOnTheTask', () {
    setUp(() => _tasksDoneTodayCubit.update([]));

    setUpAll(() {
      registerFallbackValue(taskFixture);
      registerFallbackValue(Confidence.normal);
    });

    test(
      'WHEN isDone argument is false '
      'THEN task is not set as done',
      () async {
        await _verifyUpdateTaskRepositoryArgument(isTaskMarkedAsDone: false);
      },
    );

    test(
      'WHEN isDone argument is true '
      'THEN task is set as done',
      () async {
        await _verifyUpdateTaskRepositoryArgument(isTaskMarkedAsDone: true);
      },
    );

    test(
      'WHEN task is set as done '
      'THEN then rewards 50 points',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 50);

        await _getUseCase()(
          task: taskFixture,
          howBigWasTheStep: Confidence.good,
          isTaskDone: true,
        );

        verify(() => _mockAddPointsToViewer(50)).called(1);
      },
    );

    test(
      'WHEN confidence is normal '
      'THEN then rewards 20 points',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 20);
        final useCase = _getUseCase();

        await useCase(task: taskFixture, howBigWasTheStep: Confidence.normal);

        verify(() => _mockAddPointsToViewer(20)).called(1);
      },
    );

    test(
      'WHEN confidence is good '
      'THEN then rewards 30 points',
      () async {
        _mockTypicalCalls(amountOfPointsToVerify: 30);
        final useCase = _getUseCase();

        await useCase(task: taskFixture, howBigWasTheStep: Confidence.good);

        verify(() => _mockAddPointsToViewer(30)).called(1);
      },
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
  });
}

Future<void> _verifyUpdateTaskRepositoryArgument({
  required bool isTaskMarkedAsDone,
}) async {
  _mockTypicalCalls(amountOfPointsToVerify: isTaskMarkedAsDone ? 50 : 30);

  await _getUseCase()(
    task: taskFixture,
    isTaskDone: isTaskMarkedAsDone,
    howBigWasTheStep: Confidence.good,
  );

  expect(
    (verify(() => _mockUpdateTaskRepository(captureAny())).captured[0] as Task)
        .isDone,
    isTaskMarkedAsDone,
  );
}

void _mockTypicalCalls({required int amountOfPointsToVerify}) {
  when(() => _mockGoToMainPage()).thenAnswer((invocation) async {});
  when(() => _mockUpdateTaskRepository(any())).thenAnswer((_) async {});
  when(() => _mockAddPointsToViewer(amountOfPointsToVerify))
      .thenAnswer((invocation) async {});
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
    addPointsToViewer: _mockAddPointsToViewer,
    tasksDoneTodayCubit: _tasksDoneTodayCubit,
    updateTaskRepository: _mockUpdateTaskRepository,
    nextRepetitionCalculator: _mockNextRepetitionCalculator,
  );
}
