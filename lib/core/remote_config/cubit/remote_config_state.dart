part of 'remote_config_cubit.dart';

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState({
    required bool areTagsEnabled,
    required bool areGoalsEnabled,
    required bool areQuestsEnabled,
    required bool isOnlyASingleSelectedTaskAllowed,
  }) = _State;
}
