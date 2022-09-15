import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/remote_config/cubit/remote_config_cubit.dart';
import '../../../quests/presentation/widgets/active_quest.dart';
import '../../../tasks/presentation/widgets/tasks_worked_on_today.dart';
import 'avatar.dart';

class PlayerProgressSummary extends StatelessWidget {
  const PlayerProgressSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const contraints = BoxConstraints.tightForFinite(width: 220);
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Avatar(radius: 60),
          ),
          Center(
            child: Column(
              children: [
                const _ActiveQuest(contraints: contraints),
                ConstrainedBox(
                  constraints: contraints,
                  child: const TasksWorkedOnToday(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveQuest extends StatelessWidget {
  const _ActiveQuest({Key? key, required this.contraints}) : super(key: key);

  final BoxConstraints contraints;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemoteConfigCubit, RemoteConfigState, bool>(
      selector: (state) => state.areQuestsEnabled,
      builder: (context, bool areQuestsEnabled) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: areQuestsEnabled
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ConstrainedBox(
                    constraints: contraints,
                    child: const ActiveQuest(),
                  ),
                )
              : const SizedBox(height: 0),
        );
      },
    );
  }
}
