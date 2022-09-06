import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_tags_cubit.dart';

TagsCubit setupTagsCubitMock() {
  final cubit = MockTagsCubit();
  final state = TagsState({});

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
