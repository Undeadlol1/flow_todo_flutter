import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubit/tasks_cubit.dart';
import 'filter_tasks_to_do.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

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
          final TasksState tasksState = cx.watch<TasksCubit>().state;
          final selectedTasks =
              tasksState.tasks.where((i) => i.isSelected).toList();
          final filteredTasks = cx.watch<FilteredTasksCubit>().state.tasks;
          final tasksToDisplay = _getTasksToDisplay(
            allTasks: tasksState.tasks,
            focusedOnTasks: selectedTasks,
            filteredTasks: filteredTasks,
          );

          if (tasksState is TasksLoading) {
            return const _LoadingIndicator();
          }

          return Column(
            children: [
              if (tasksState.tasks.length > 10) const FilterTasksToDo(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasksToDisplay.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return TasksListItem(task: tasksToDisplay[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  List<Task> _getTasksToDisplay({
    required List<Task> allTasks,
    required List<Task> focusedOnTasks,
    required List<Task> filteredTasks,
  }) {
    final allTasksWitouthFilteredTasks = filteredTasks.isEmpty
        ? allTasks
        : allTasks.where((task) => filteredTasks.contains(task)).toList();

    final allTasksListWithoutSelectedAndFilteredTasks =
        allTasksWitouthFilteredTasks
            .where((task) => !focusedOnTasks.contains(task))
            .toList();

    return allTasksListWithoutSelectedAndFilteredTasks;
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
