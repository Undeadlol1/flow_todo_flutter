import 'package:flow_todo_flutter_2022/features/quests/presentation/cubits/active_quests_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../leveling/domain/services/user_level_calculator.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';

class ActiveQuest extends StatelessWidget {
  ActiveQuest({Key? key}) : super(key: key);
  final _levelCalculator = GetIt.I<UserLevelCalculator>();

  static const _padding = EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 4,
  );

  @override
  Widget build(context) {
    return Builder(
      builder: (context) {
        final profileState = context.watch<ProfileCubit>().state;
        final questsState = context.watch<ActiveQuestsCubit>().state;
        return questsState.maybeMap(
          orElse: _getLoadingWidget,
          loaded: (_) {
            final level =
                _levelCalculator(profileState.profile?.experience ?? 0).value;

            return Padding(
              padding: _padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text('Quest: ${questsState.quests.first.type.name}'),
                  Text('Quest: reach level ${level + 5}'),
                  const _ProgressBar(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _getLoadingWidget() => const SizedBox();
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: LinearProgressIndicator(value: 0.5),
    );
  }
}
