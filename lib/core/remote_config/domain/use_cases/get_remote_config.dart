import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRemoteConfig {
  final RemoteConfigCubit remoteConfigCubit;
  final FirebaseRemoteConfig firebaseRemoteConfig;
  const GetRemoteConfig({
    required this.remoteConfigCubit,
    required this.firebaseRemoteConfig,
  });

  Future<void> call() async {
    await firebaseRemoteConfig.fetch();

    remoteConfigCubit.update(
      RemoteConfigState(
        areTagsEnabled: _getBoolean('are_tags_enabled'),
        isOnlyASingleSelectedTaskAllowed:
            _getBoolean('keis_only_single_selected_task_allowedy'),
      ),
    );
  }

  bool _getBoolean(String code) => firebaseRemoteConfig.getBool(code);
}
