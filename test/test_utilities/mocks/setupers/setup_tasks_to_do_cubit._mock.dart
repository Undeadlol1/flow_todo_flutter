import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_tasks_to_do_cubit.dart';

TasksToDoCubit setupTasksToDoCubitMock() {
  final cubit = MockTasksToDoCubit();
  final state = TasksToDoState.loaded([]);

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
