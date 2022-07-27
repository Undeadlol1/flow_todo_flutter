part of 'active_quests_cubit.dart';

@freezed
class ActiveQuestsState with _$ActiveQuestsState {
  final List<QuestEntity> quests = [];
  ActiveQuestsState._();

  factory ActiveQuestsState.loading() = _Loading;
  factory ActiveQuestsState.loaded(List<QuestEntity> quests) = _loaded;
}
