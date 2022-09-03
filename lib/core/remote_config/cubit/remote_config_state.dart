part of 'remote_config_cubit.dart';

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState({
    required bool areTagsEnabled,
    required bool areGoalsEnabled,
    required bool areQuestsEnabled,
    required bool isOnlyASingleSelectedTaskAllowed,
    required bool isTasksListSeparatorColorRandom,
  }) = _State;

  factory RemoteConfigState.defaults({
    @Default(true) final bool areTagsEnabled,
    @Default(false) final bool areGoalsEnabled,
    @Default(false) final bool areQuestsEnabled,
    @Default(true) final bool isOnlyASingleSelectedTaskAllowed,
    @Default(false) final bool isTasksListSeparatorColorRandom,
  }) = _Defaults;
}
