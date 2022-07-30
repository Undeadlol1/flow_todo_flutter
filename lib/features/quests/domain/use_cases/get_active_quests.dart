import 'package:flow_todo_flutter_2022/features/quests/data/get_active_quests_repository.dart';
import 'package:flow_todo_flutter_2022/features/quests/presentation/cubits/active_quests_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetActiveQuests {
  final ActiveQuestsCubit activeQuestsCubit;
  final GetActiveQuestsRepository getQuests;

  const GetActiveQuests({
    required this.getQuests,
    required this.activeQuestsCubit,
  });

  Future<void> call({required String userId}) async {
    activeQuestsCubit.setLoading();

    return getQuests(userId: userId).then(activeQuestsCubit.update);
  }
}
