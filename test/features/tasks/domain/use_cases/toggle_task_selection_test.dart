import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/toggle_task_selection.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';
import '../../../../test_utilities/mocks/mock_firebase_analytics.dart';
import '../../../../test_utilities/mocks/mock_remote_config_cubit.dart';
import '../../../../test_utilities/mocks/mock_tasks_to_do_cubit.dart';
import '../../../../test_utilities/mocks/mock_update_task_repository.dart';

final _tasksCubit = MockTasksToDoCubit();
final _mockFirebaseAnalytics = MockFirebaseAnalytics();
final _mockRemoteConfigCubit = MockRemoteConfigCubit();
final _updateTaskRepository = MockUpdateTaskRepository();

void main() {
  ToggleTaskSelection getUseCase() {
    return ToggleTaskSelection(
      tasksCubit: _tasksCubit,
      firebaseAnalytics: _mockFirebaseAnalytics,
      remoteConfigCubit: _mockRemoteConfigCubit,
      updateTaskRepository: _updateTaskRepository,
    );
  }

  setUpAll(() {
    registerFallbackValue(taskFixture);
    registerFallbackValue('testing event name');

    when(() => _tasksCubit.state).thenReturn(TasksToDoState.loaded([]));
    when(() => _tasksCubit.updateTask(any())).thenReturn(null);
    when(() => _mockRemoteConfigCubit.state)
        .thenReturn(RemoteConfigState.defaults());
    when(() => _updateTaskRepository(any())).thenAnswer((_) async {});
    when(() => _mockFirebaseAnalytics.logEvent(name: any(named: 'name')))
        .thenAnswer((_) async {});
  });

  setUp(() => resetMocktailState());

  group('GIVEN ToggleTaskSelection', () {
    test('WHEN there are no selected tasks THEN updates the task', () async {
      when(() => _tasksCubit.state).thenReturn(TasksToDoState.loaded([]));

      await getUseCase()(taskFixture);

      final updatedTask = taskFixture.copyWith(isSelected: true);
      _verifyTaskUpdates(updatedTask);
    });

    test('WHEN the task is already selected THEN deselects the task', () async {
      final selectedTask = taskFixture.copyWith(isSelected: true);
      when(() => _tasksCubit.state)
          .thenReturn(TasksToDoState.loaded([selectedTask]));

      await getUseCase()(selectedTask);

      _verifyTaskUpdates(selectedTask.copyWith(isSelected: false));
    });

    test(
      'WHEN only a single task is allowed to be selected via remote config'
      'AND there is a task selected already '
      'THEN does nothing',
      () async {
        when(() => _mockRemoteConfigCubit.state).thenReturn(
          RemoteConfigState.defaults(isOnlyASingleSelectedTaskAllowed: true),
        );
        when(() => _tasksCubit.state).thenReturn(
          TasksToDoState.loaded([taskFixture.copyWith(isSelected: true)]),
        );

        await getUseCase()(taskFixture2);

        verifyNever(() => _tasksCubit.updateTask(any()));
        verifyNever(() => _updateTaskRepository.call(any()));
      },
    );

    test(
      'WHEN multiple tasks are allowed to be selected via remote config'
      'AND there is a task selected already '
      'THEN updates the task',
      () async {
        when(() => _mockRemoteConfigCubit.state).thenReturn(
          RemoteConfigState.defaults(isOnlyASingleSelectedTaskAllowed: false),
        );
        when(() => _tasksCubit.state).thenReturn(
          TasksToDoState.loaded([taskFixture.copyWith(isSelected: true)]),
        );

        await getUseCase()(taskFixture2);

        _verifyTaskUpdates(taskFixture2.copyWith(isSelected: true));
      },
    );
  });
}

void _verifyTaskUpdates(Task updatedTask) {
  final stateChangeVerification =
      verify(() => _tasksCubit.updateTask(captureAny()));
  final repositoryCallVerificaiton =
      verify(() => _updateTaskRepository.call(captureAny()));

  stateChangeVerification.called(1);
  repositoryCallVerificaiton.called(1);

  expect(stateChangeVerification.captured[0], equals(updatedTask));
  expect(repositoryCallVerificaiton.captured[0], equals(updatedTask));
}
