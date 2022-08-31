part of 'remote_config_cubit.dart';

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState({
    required bool areTagsEnabled,
    required bool isOnlyASingleSelectedTaskAllowed,
  }) = _State;
}
