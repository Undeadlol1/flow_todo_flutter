import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filter_by_tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' hide log;

import '../cubit/tasks_to_do_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  final bool shouldIgnoreTagsFiltering;
  final bool shouldIgnoreStaleCondition;
  const TasksList({
    Key? key,
    this.shouldIgnoreTagsFiltering = false,
    this.shouldIgnoreStaleCondition = false,
  }) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  build(_) {
    return Builder(
      builder: (cx) {
        final Set<String> tags =
            cx.select((FilterByTagsCubit cubit) => cubit.state.tags);
        final TasksToDoState tasksState = cx.watch<TasksToDoCubit>().state;
        final selectedTasks =
            tasksState.tasks.where((i) => i.isSelected).toList();
        final filteredTasks =
            cx.select((FilteredTasksCubit cubit) => cubit.state.tasks);
        final List<Task> tasksToDisplay = _getTasksToDisplay(
          tags: tags,
          allTasks: tasksState.tasks,
          filteredTasks: filteredTasks,
          focusedOnTasks: selectedTasks,
        );
        final bool doesTasksListSeparatorHasRandomColors = cx.select(
          (RemoteConfigCubit cubit) =>
              cubit.state.isTasksListSeparatorColorRandom,
        );

        return tasksState.map(
          loading: (_) => const _LoadingIndicator(),
          loaded: (_) => Column(
            children: [
              if (tasksState.tasks.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: _TasksLeftText(amount: tasksToDisplay.length),
                ),
              if (widget.shouldIgnoreTagsFiltering == false) const TagsList(),
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                addRepaintBoundaries: false,
                addAutomaticKeepAlives: true,
                itemCount: tasksToDisplay.length,
                cacheExtent: (81 * tasksToDisplay.length).toDouble(),
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => _Separator(
                  isRandomizedColor: doesTasksListSeparatorHasRandomColors,
                ),
                itemBuilder: (_, index) {
                  return TasksListItem(
                    task: tasksToDisplay[index],
                    shouldIgnoreStaleCondition:
                        widget.shouldIgnoreStaleCondition,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<Task> _getTasksToDisplay({
    required Set<String> tags,
    required List<Task> allTasks,
    required List<Task> focusedOnTasks,
    required List<Task> filteredTasks,
  }) {
    if (widget.shouldIgnoreTagsFiltering == false && tags.isNotEmpty) {
      final allTasksWithoutSelectedTasks =
          allTasks.where((task) => !focusedOnTasks.contains(task)).toList();
      return _filterTasksByTag(
        tags: tags,
        tasks: allTasksWithoutSelectedTasks,
      );
    }

    final allTasksWitoutFilteredTasks = filteredTasks.isEmpty
        ? allTasks
        : allTasks.where((task) => filteredTasks.contains(task)).toList();

    final allTasksListWithoutSelectedAndFilteredTasks =
        allTasksWitoutFilteredTasks
            .where((task) => !focusedOnTasks.contains(task))
            .toList();
    return allTasksListWithoutSelectedAndFilteredTasks;
  }

  List<Task> _filterTasksByTag({
    required Set<String> tags,
    required List<Task> tasks,
  }) {
    final List<Task> filteredTasks = [];

    for (final tag in tags) {
      for (final task in tasks) {
        if (tag == 'stale' && task.isStale) {
          filteredTasks.add(task);
        }

        if (tag == 'fresh' && !task.isStale) {
          filteredTasks.add(task);
        }

        if (task.tags.map((e) => e.toLowerCase()).contains(tag) &&
            !filteredTasks.contains(task)) {
          filteredTasks.add(task);
        }
      }
    }

    return filteredTasks;
  }
}

class _Separator extends StatelessWidget {
  final bool isRandomizedColor;
  const _Separator({Key? key, required this.isRandomizedColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRandomizedColor
        ? Container(
            color: Color(
              (Random().nextDouble() * 0xFFFFFF).toInt(),
            ).withOpacity(1.0),
            child: const SizedBox(height: 5),
          )
        : const Divider(
            height: 5,
            thickness: 2,
          );
  }
}

class _TasksLeftText extends StatelessWidget {
  const _TasksLeftText({Key? key, required this.amount}) : super(key: key);

  final int amount;
  static const _revealDuration = Duration(milliseconds: 500);
  static const _textStyle = TextStyle(fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _revealDuration,
      reverseDuration: _revealDuration,
      child: amount > 1
          ? Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Tasks left: ',
                    style: _textStyle,
                  ),
                  AnimatedNumbers(
                    number: amount,
                    style: _textStyle,
                    duration: const Duration(seconds: 1),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
