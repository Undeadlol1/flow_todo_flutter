import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tags_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/tasks_cubit.dart';
import '../pages/filter_tasks_page.dart';
import 'filter_tasks_to_do.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  final bool shouldIgnoreTagsFiltering;
  final bool shouldIgnoreStaleCondition;
  const TasksList({
    Key? key,
    this.shouldIgnoreStaleCondition = false,
    this.shouldIgnoreTagsFiltering = false,
  }) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _filteredTasksCubit = GetIt.I<FilteredTasksCubit>();

  @override
  build(_) {
    return BlocProvider(
      create: (_) => _filteredTasksCubit,
      child: Builder(
        builder: (cx) {
          final TagsState tagsState = cx.watch<TagsCubit>().state;
          final TasksState tasksState = cx.watch<TasksCubit>().state;
          final selectedTasks =
              tasksState.tasks.where((i) => i.isSelected).toList();
          final filteredTasks = cx.watch<FilteredTasksCubit>().state.tasks;
          final List<Task> tasksToDisplay = _getTasksToDisplay(
            allTasks: tasksState.tasks,
            filteredTasks: filteredTasks,
            tags: tagsState.tags.toList(),
            focusedOnTasks: selectedTasks,
          );

          if (tasksState is TasksLoading) {
            return const _LoadingIndicator();
          }

          return CardView(
            child: Column(
              children: [
                if (tasksState.tasks.length > 10 &&
                    _isViewerOnFilterPage(context))
                  const FilterTasksToDo(),
                if (tasksState.tasks.isNotEmpty)
                  _TasksLeftText(amount: tasksToDisplay.length),
                if (widget.shouldIgnoreTagsFiltering == false) const TagsList(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasksToDisplay.length,
                  prototypeItem: tasksToDisplay.isEmpty
                      ? const SizedBox()
                      : TasksListItem(task: tasksToDisplay.first),
                  physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }

  List<Task> _getTasksToDisplay({
    required List<String> tags,
    required List<Task> allTasks,
    required List<Task> focusedOnTasks,
    required List<Task> filteredTasks,
  }) {
    if (widget.shouldIgnoreTagsFiltering == false && tags.isNotEmpty) {
      final allTasksWithouthSelectedTasks =
          allTasks.where((task) => !focusedOnTasks.contains(task)).toList();
      return _filterTasksByTag(
        tags: tags,
        tasks: allTasksWithouthSelectedTasks,
      );
    }

    final allTasksWitouthFilteredTasks = filteredTasks.isEmpty
        ? allTasks
        : allTasks.where((task) => filteredTasks.contains(task)).toList();

    final allTasksListWithoutSelectedAndFilteredTasks =
        allTasksWitouthFilteredTasks
            .where((task) => !focusedOnTasks.contains(task))
            .toList();
    return allTasksListWithoutSelectedAndFilteredTasks;
  }

  List<Task> _filterTasksByTag({
    required List<String> tags,
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

        if (task.tags.map((e) => e.toLowerCase()).contains(tag)) {
          filteredTasks.add(task);
        }
      }
    }

    return filteredTasks;
  }
}

class _TasksLeftText extends StatelessWidget {
  const _TasksLeftText({
    Key? key,
    required this.amount,
  }) : super(key: key);

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
                  AnimatedNumbers(number: amount, style: _textStyle),
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
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

bool _isViewerOnFilterPage(BuildContext context) =>
    ModalRoute.of(context)?.settings.name == FilterTasksPage.pathName;
