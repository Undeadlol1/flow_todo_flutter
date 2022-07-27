import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/entities/quest_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_quests_state.dart';
part 'active_quests_cubit.freezed.dart';

class ActiveQuestsCubit extends Cubit<ActiveQuestsState> {
  ActiveQuestsCubit() : super(ActiveQuestsState.loading());

  void update(List<QuestEntity> quests) {
    emit(ActiveQuestsState.loaded(quests));
  }
}
