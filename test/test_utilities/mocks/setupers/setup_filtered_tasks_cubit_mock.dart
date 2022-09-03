import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:mocktail/mocktail.dart';

class _MockFilteredTasksCubit extends Mock implements FilteredTasksCubit {}

FilteredTasksCubit setupFileredTasksCubitMock() {
  final cubit = _MockFilteredTasksCubit();
  final state = FilteredTasksState([]);

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
