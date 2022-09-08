import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/profile_fixture.dart';
import '../mock_profile_cubit.dart';

ProfileCubit setupProfileCubitMock() {
  final cubit = MockProfileCubit();
  final state = ProfileLoaded(profile: profileFixture);

  whenListen(
    cubit,
    Stream.value(state),
    initialState: state,
  );

  when(() => cubit.close()).thenAnswer((_) async {});

  return cubit;
}
