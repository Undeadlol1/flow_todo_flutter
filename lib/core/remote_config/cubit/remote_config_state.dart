part of 'remote_config_cubit.dart';

@freezed
class RemoteConfigState with _$RemoteConfigState {
  const factory RemoteConfigState({
    required bool areTagsEnabled,
    required bool areGoalsEnabled,
    required bool areQuestsEnabled,
    required bool isStaleDetectionEnabled,
    required bool isOnlyASingleSelectedTaskAllowed,
    required bool isTasksListSeparatorColorRandom,
    required bool isMassCompletionOfSelectedTasksAvailable,
  }) = _State;

  factory RemoteConfigState.defaults({
    @Default(true) final bool areTagsEnabled,
    @Default(false) final bool areGoalsEnabled,
    @Default(false) final bool areQuestsEnabled,
    @Default(false) final bool isStaleDetectionEnabled,
    @Default(true) final bool isOnlyASingleSelectedTaskAllowed,
    @Default(false) final bool isTasksListSeparatorColorRandom,
    @Default(false) final bool isMassCompletionOfSelectedTasksAvailable,
  }) = _Defaults;
}
