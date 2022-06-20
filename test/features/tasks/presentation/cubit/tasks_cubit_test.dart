import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utilities/fixtures/task_fixture.dart';
import '../../../../test_utilities/fixtures/task_fixture_2.dart';

void main() {
  group('GIVEN TasksCubit', () {
    blocTest<TasksCubit, TasksState>(
      'WHEN is loaded initially '
      'THEN contains empty tasks list',
      build: () => TasksCubit(),
      verify: (cubit) {
        expect(cubit.state, isA<TasksLoading>());
        expect(cubit.state.tasks, equals([]));
      },
    );

    blocTest<TasksCubit, TasksState>(
      'WHEN is updated'
      'THEN contains updated tasks list',
      build: () => TasksCubit(),
      act: (cubit) => cubit.updateList([taskFixture, taskFixture]),
      verify: (cubit) {
        expect(cubit.state, isA<TasksUpdated>());
        expect(cubit.state.tasks, equals([taskFixture, taskFixture]));
      },
    );

    blocTest<TasksCubit, TasksState>(
      'WHEN removeTask method is called'
      'THEN removes the task from the state',
      build: () => TasksCubit()..updateList([taskFixture2, taskFixture]),
      act: (cubit) => cubit.removeTask(taskFixture2),
      verify: (cubit) {
        expect(cubit.state, isA<TasksUpdated>());
        expect(cubit.state.tasks, equals([taskFixture]));
      },
    );
  });
}
