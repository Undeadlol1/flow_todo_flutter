import 'package:flow_todo_flutter_2022/features/quests/domain/entities/quest_type_entity.dart';
import 'package:flow_todo_flutter_2022/features/quests/domain/models/quest.dart';
import 'package:flow_todo_flutter_2022/features/quests/presentation/cubits/active_quests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveQuest extends StatelessWidget {
  const ActiveQuest({Key? key}) : super(key: key);

  static const _padding = EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 4,
  );

  @override
  Widget build(context) {
    return Builder(
      builder: (context) {
        final questsState = context.watch<ActiveQuestsCubit>().state;
        return questsState.maybeMap(
          orElse: _getLoadingWidget,
          loaded: (_) {
            if (questsState.quests.isEmpty) {
              return const SizedBox();
            }

            final Quest activeQuest = questsState.quests.first;

            return Padding(
              padding: _padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text('Quest: ${_getQuestText(activeQuest)}'),
                  // const _ProgressBar(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _getLoadingWidget() => const SizedBox();

  String _getQuestText(Quest quest) {
    switch (quest.type) {
      case QuestTypeEntity.createTasks:
        return 'create ${quest.valueToAchieve} tasks';
      case QuestTypeEntity.completeTasks:
        return 'complete ${quest.valueToAchieve} tasks';
      case QuestTypeEntity.reachLevel:
        return 'reach level ${quest.valueToAchieve}';
      default:
        return 'Quest type not mapped';
    }
  }
}

// class _ProgressBar extends StatelessWidget {
//   const _ProgressBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       child: LinearProgressIndicator(value: 0.5),
//     );
//   }
// }
