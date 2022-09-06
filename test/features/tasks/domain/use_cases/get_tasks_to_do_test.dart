import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/get_tasks_to_do.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/mocks/mock_get_tasks_repository.dart';
import '../../../../test_utilities/mocks/mock_tasks_to_do_cubit.dart';
import '../../../../test_utilities/mocks/mock_use_case_exception_handler.dart';

void main() {
  const userId = '123';
  final mockTasksCubit = MockTasksToDoCubit();
  final mockGetTasksRepository = MockGetTasksToDoRepository();

  setUpAll(() {
    when(() => mockGetTasksRepository(userId: userId))
        .thenAnswer((_) async => [taskFixture, taskFixture]);
  });

  setUp(() {
    reset(mockTasksCubit);

    final tasksState = TasksToDoState.loaded([]);
    whenListen(
      mockTasksCubit,
      Stream.fromIterable([tasksState]),
      initialState: tasksState,
    );
  });

  group('GIVEN GetTasksToDo use case', () {
    test('WHEN called THEN calls repository', () async {
      await GetTasksToDo(
        tasksCubit: mockTasksCubit,
        getTasks: mockGetTasksRepository,
        exceptionHandler: MockUseCaseExceptionHandler(),
      )(userId: userId);

      verify(() => mockGetTasksRepository(userId: userId)).called(1);
    });

    test('WHEN tasks are fetched THEN updates tasks state', () async {
      await GetTasksToDo(
        tasksCubit: mockTasksCubit,
        getTasks: mockGetTasksRepository,
        exceptionHandler: MockUseCaseExceptionHandler(),
      )(userId: userId);

      verify(() => mockTasksCubit.updateList([taskFixture, taskFixture]))
          .called(1);
    });
  });
}
