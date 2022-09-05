import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_tasks_cubit.dart';

TasksCubit setupTasksCubitMock() {
  final cubit = MockTasksCubit();
  final state = TasksState.loaded([]);

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
