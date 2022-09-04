import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';
import '../../../../test_utilities/mocks/mock_hydrated_storage.dart';

class _MockStorage extends Mock implements Storage {}

void main() {
  late TasksCubit tasksCubit;
  late Storage hydratedStorage;

  setUp(() async {
    tasksCubit = await mockHydratedStorage(() => TasksCubit());

    hydratedStorage = _MockStorage();
    when(() => hydratedStorage.write(any(), any<dynamic>()))
        .thenAnswer((_) async {});
  });

  group('GIVEN TasksCubit', () {
    blocTest<TasksCubit, TasksState>(
      'WHEN is loaded initially '
      'THEN contains empty tasks list',
      build: () => tasksCubit,
      verify: (cubit) {
        expect(
          cubit.state.maybeMap(
            loading: (value) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(cubit.state.tasks, equals([]));
      },
    );

    blocTest<TasksCubit, TasksState>(
      'WHEN updateList is called '
      'THEN contains updated tasks list',
      build: () => tasksCubit,
      act: (cubit) => cubit.updateList([taskFixture, taskFixture]),
      verify: (cubit) {
        expect(
          cubit.state.maybeMap(
            loaded: (value) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(cubit.state.tasks, equals([taskFixture, taskFixture]));
      },
    );

    blocTest<TasksCubit, TasksState>(
      'WHEN is updateTask is called '
      'THEN updates the task in the list',
      build: () => tasksCubit..updateList([taskFixture, taskFixture2]),
      act: (cubit) =>
          cubit.updateTask(taskFixture.copyWith(title: 'a new title')),
      verify: (cubit) {
        expect(
          cubit.state.maybeMap(
            loaded: (value) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(cubit.state.tasks, hasLength(2));
        expect(cubit.state.tasks.first.title, 'a new title');
      },
    );

    blocTest<TasksCubit, TasksState>(
      'WHEN removeTask method is called'
      'THEN removes the task from the state',
      build: () => tasksCubit..updateList([taskFixture2, taskFixture]),
      act: (cubit) => cubit.removeTask(taskFixture2),
      verify: (cubit) {
        expect(
          cubit.state.maybeMap(
            loaded: (value) => true,
            orElse: () => false,
          ),
          isTrue,
        );
        expect(cubit.state.tasks, equals([taskFixture]));
      },
    );
  });
}
