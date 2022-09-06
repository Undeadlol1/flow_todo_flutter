import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filter_by_tags_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_filter_by_tags_cubit.dart';

FilterByTagsCubit setupFilterByTagsCubitMock() {
  final cubit = MockFilterByTagsCubit();
  final state = FilterByTagsState({});

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
