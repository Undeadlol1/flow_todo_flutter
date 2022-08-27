import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/entities/confidence.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/task_reward_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/toggle_task_selection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/use_cases/go_to_task_page.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  static final StaleTaskDetector _staleTaskDetector = GetIt.I();
  static final TaskRewardCalculator _rewardCalculator = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<String>(task.id),
      direction: DismissDirection.startToEnd,
      background: const _DismissibleBackground(),
      onDismissed: (DismissDirection direction) {
        GetIt.I<MakeStepForwardOnTheTask>()(
          task: task,
          isTaskDone: true,
          howBigWasTheStep: Confidence.good,
        );
      },
      child: ListTile(
        dense: false,
        enableFeedback: true,
        title: Text(task.title),
        selected: task.isSelected,
        subtitle: Text(
          _staleTaskDetector.isTale(task)
              ? '💩'
              : 'Reward: ${_rewardCalculator(task)} experience',
        ),
        onTap: () => GetIt.I<GoToTaskPage>()(task: task),
        onLongPress: () => GetIt.I<ToggleTaskSelection>()(task),
      ),
    );
  }
}

class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      color: theme.focusColor,
      child: Text(
        'Complete the task',
        style: theme.textTheme.subtitle2?.copyWith(fontStyle: FontStyle.italic),
      ),
    );
  }
}
