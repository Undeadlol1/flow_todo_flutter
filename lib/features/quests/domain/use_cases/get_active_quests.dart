import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/quests/data/get_active_quests_repository.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/tutorial_quests.dart';
import 'package:flow_todo_flutter_2022/features/quests/presentation/cubits/active_quests_cubit.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetActiveQuests {
  final ActiveQuestsCubit activeQuestsCubit;
  final UniqueIdGenerator uniqueIdGenerator;
  final GetActiveQuestsRepository getQuests;

  const GetActiveQuests({
    required this.getQuests,
    required this.uniqueIdGenerator,
    required this.activeQuestsCubit,
  });

  Future<void> call({required String userId}) async {
    activeQuestsCubit.setLoading();

    final fetchedQuests = await getQuests(userId: userId);

    if (fetchedQuests.isEmpty) {}

    return activeQuestsCubit.update(
      fetchedQuests.isEmpty ? _getTutorialQuest(userId) : fetchedQuests,
    );
  }

  List<Quest> _getTutorialQuest(String userId) {
    return [
      Quest(
        isDone: false,
        userId: userId,
        id: uniqueIdGenerator(),
        createdAt: DateTime.now(),
        type: tutorialQuests.entries.first.key,
      )
    ];
  }
}
