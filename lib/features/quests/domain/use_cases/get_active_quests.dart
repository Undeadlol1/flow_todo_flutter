import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/quests/data/create_quest_repository.dart';
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
  final CreateQuestRepository createQuestRepository;

  const GetActiveQuests({
    required this.getQuests,
    required this.uniqueIdGenerator,
    required this.activeQuestsCubit,
    required this.createQuestRepository,
  });

  Future<void> call({required String userId}) async {
    activeQuestsCubit.setLoading();

    final fetchedQuests = await getQuests(userId: userId);
    final tutorialQuest = _getTutorialQuest(userId);
    final questsToDisplay =
        fetchedQuests.isEmpty ? [tutorialQuest] : fetchedQuests;

    if (fetchedQuests.isEmpty) {
      // await createQuestRepository.call(tutorialQuest);
    }

    return activeQuestsCubit.update(questsToDisplay);
  }

  Quest _getTutorialQuest(String userId) {
    return Quest(
      isDone: false,
      userId: userId,
      // TODO:
      // isPartOfTutorial: true,
      id: uniqueIdGenerator(),
      createdAt: DateTime.now(),
      initialValue: 0,
      achievementProgress: 0,
      type: tutorialQuests.entries.first.key,
      valueToAchieve: tutorialQuests.entries.first.value,
    );
  }
}
