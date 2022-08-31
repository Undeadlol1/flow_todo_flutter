import 'package:bloc_test/bloc_test.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_remote_config_cubit.dart';

RemoteConfigCubit setupRemoteConfigCubitMock() {
  final remoteConfigCubit = MockRemoteConfigCubit();
  const remoteConfigState = RemoteConfigState(
    areGoalsEnabled: false,
    areQuestsEnabled: false,
    areTagsEnabled: false,
    isOnlyASingleSelectedTaskAllowed: false,
  );
  whenListen(
    remoteConfigCubit,
    Stream.value(remoteConfigState),
    initialState: remoteConfigState,
  );
  when(() => remoteConfigCubit.close()).thenAnswer((_) async {});

  return remoteConfigCubit;
}
