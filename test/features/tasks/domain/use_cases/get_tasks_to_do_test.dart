import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do.dart' as repository;
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/get_tasks_to_do.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';

class _MockGetTasksToDo extends Mock implements repository.GetTasksToDo {}

void main() {
  const userId = '123';
  final tasksCubit = TasksCubit();
  final mockGetTasksRepository = _MockGetTasksToDo();

  setUpAll(() {
    when(() => mockGetTasksRepository(userId: userId))
        .thenAnswer((_) async => [taskFixture, taskFixture]);

    GetIt.I.registerSingleton(tasksCubit);
    GetIt.I.registerSingleton<repository.GetTasksToDo>(mockGetTasksRepository);
  });

  group('GIVEN GetTasksToDo use case ', () {
    test('WHEN called THEN calls repository', () async {
      await const GetTasksToDo()(userId: userId);

      verify(() => mockGetTasksRepository(userId: userId)).called(1);
    });

    test('WHEN tasks are fetched THEN updates tasks state', () async {
      await const GetTasksToDo()(userId: userId);

      expect(tasksCubit.state.tasks, equals([taskFixture, taskFixture]));
    });
  });
}
