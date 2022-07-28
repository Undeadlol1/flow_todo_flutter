part of 'active_quests_cubit.dart';

@freezed
class ActiveQuestsState with _$ActiveQuestsState {
  final List<Quest> quests = [];
  ActiveQuestsState._();

  factory ActiveQuestsState.loading() = _Loading;
  factory ActiveQuestsState.loaded(List<Quest> quests) = _loaded;
}
