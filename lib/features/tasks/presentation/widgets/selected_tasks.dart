import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_to_do_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'tasks_list_item.dart';

class SelectedTasks extends StatelessWidget {
  const SelectedTasks({Key? key}) : super(key: key);
  static const _textPadding = EdgeInsets.symmetric(horizontal: 14);
  static final FirebaseRemoteConfig firebaseRemoteConfig = GetIt.I();
  static final TaskRewardCalculator taskRewardCalculator = GetIt.I();

  @override
  build(context) {
    return BlocBuilder<TasksToDoCubit, TasksToDoState>(
      builder: (context, tasksState) {
        final tasks = tasksState.tasks.where((i) => i.isSelected).toList();
        final totalExperience = _getTotalExperience(tasks);
        final isOnlyASingleTaskAllowed = firebaseRemoteConfig
            .getBool('is_only_single_selected_task_allowed');

        if (tasks.isEmpty) {
          return const SizedBox();
        }

        return CardView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: _textPadding,
                child: Text(
                  'Selected task${isOnlyASingleTaskAllowed ? '' : 's'}:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: _textPadding,
                child: Text(
                  '${isOnlyASingleTaskAllowed ? '' : '($totalExperience total experience) '}(rewards are doubled)',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              const Divider(thickness: 0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => TasksListItem(task: tasks[index]),
              ),
            ],
          ),
        );
      },
    );
  }

  int _getTotalExperience(List<Task> tasks) {
    final totalExperience = tasks
        .map((task) => taskRewardCalculator.taskCompletion(task))
        .toList()
        .fold(
          0,
          (int previous, int current) => previous + current,
        );
    return totalExperience;
  }
}
