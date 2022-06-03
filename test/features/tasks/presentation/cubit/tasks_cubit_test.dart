import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GIVEN TasksCubit', () {
    blocTest<TasksCubit, TasksState>(
      'WHEN is loaded initially '
      'THEN contains empty tasks list',
      build: () => TasksCubit(),
      verify: (cubit) {
        expect(cubit.state, isA<TasksInitial>());
        expect(cubit.state.tasks, equals([]));
      },
    );
  });
}
