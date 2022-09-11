import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_fade_in_on_visibility.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/toggle_tags_selection.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filter_by_tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/tasks_to_do_cubit.dart';

class TagsList extends StatelessWidget {
  const TagsList({Key? key}) : super(key: key);
  static final ToggleTagsSelection _toggleTagsSelection = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RemoteConfigCubit, RemoteConfigState, bool>(
      selector: (state) => state.areTagsEnabled,
      builder: (_, areTagsEnabled) {
        return BlocBuilder<TasksWorkedOnTodayCubit, TasksWorkedOnTodayState>(
          builder: (_, tasksWorkedOnTodayState) {
            return BlocBuilder<FilterByTagsCubit, FilterByTagsState>(
              builder: (_, tagsState) {
                return BlocBuilder<TasksToDoCubit, TasksToDoState>(
                  buildWhen: _haveTagsChanged,
                  builder: (context, tasksState) {
                    final tasks = tasksState.tasks;
                    final areThereStaleTasks =
                        tasks.any((task) => task.isStale);
                    final areThereFreshTasks =
                        tasks.any((task) => !task.isStale);

                    if (areTagsEnabled && tasks.length > 5) {
                      final tags = _getTags(tasksState);

                      if (areThereStaleTasks) {
                        tags.add('stale');
                      }

                      if (areThereFreshTasks) {
                        tags.add('fresh');
                      }

                      return ExpansionTile(
                        title: const Text('Tags'),
                        children: <Widget>[
                          Wrap(
                            children: tags.map(
                              (tag) {
                                final int tasksDoneTodayWithTag =
                                    tasksWorkedOnTodayState.tasks
                                        .where((i) => i.tags.contains(tag))
                                        .length;
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: FilterChip(
                                    showCheckmark: false,
                                    avatar: tasksDoneTodayWithTag > 0
                                        ? _TasksWorkedOnAmountText(
                                            amount: tasksDoneTodayWithTag,
                                          )
                                        : null,
                                    visualDensity: VisualDensity.compact,
                                    selected: tagsState.tags.contains(tag),
                                    onSelected: (_) =>
                                        _toggleTagsSelection(tag),
                                    label: Text(tag),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Set<String> _getTags(TasksToDoState tasksState) {
    final allTags = tasksState.tasks.map((e) => e.tags);
    final uniqueTags = allTags
        .expand((list) => list.map((e) => e))
        .map((e) => e.toLowerCase())
        .toList()
      ..sort();

    return uniqueTags.toSet();
  }

  bool _haveTagsChanged(TasksToDoState previous, TasksToDoState current) {
    return !setEquals(_getTags(previous), _getTags(current));
  }
}

class _TasksWorkedOnAmountText extends StatelessWidget {
  final int amount;
  const _TasksWorkedOnAmountText({Key? key, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeInOnVisibility(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          shape: BoxShape.circle,
        ),
        child: Text(
          amount.toString(),
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
