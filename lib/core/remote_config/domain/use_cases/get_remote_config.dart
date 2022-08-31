import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRemoteConfig {
  final RemoteConfigCubit remoteConfigCubit;
  final FirebaseRemoteConfig firebaseRemoteConfig;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const GetRemoteConfig({
    required this.remoteConfigCubit,
    required this.firebaseRemoteConfig,
    required this.useCaseExceptionHandler,
  });

  Future<void> call() async {
    try {
      await firebaseRemoteConfig.fetch();

      remoteConfigCubit.update(
        RemoteConfigState(
          areTagsEnabled: _getBoolean('are_tags_enabled'),
          areGoalsEnabled: _getBoolean('are_goals_enabled'),
          areQuestsEnabled: _getBoolean('are_quests_enabled'),
          isOnlyASingleSelectedTaskAllowed:
              _getBoolean('keis_only_single_selected_task_allowedy'),
        ),
      );
    } catch (e) {
      useCaseExceptionHandler.call(e, StackTrace.current);
    }
  }

  bool _getBoolean(String code) => firebaseRemoteConfig.getBool(code);
}
