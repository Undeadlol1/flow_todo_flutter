import 'package:bloc/bloc.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'active_quests_state.dart';
part 'active_quests_cubit.freezed.dart';

@singleton
class ActiveQuestsCubit extends Cubit<ActiveQuestsState> {
  ActiveQuestsCubit() : super(ActiveQuestsState.loading());

  void update(List<Quest> quests) {
    emit(ActiveQuestsState.loaded(quests));
  }

  void setLoading() {
    emit(ActiveQuestsState.loading());
  }
}
