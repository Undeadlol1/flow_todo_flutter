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
          final filteredTasks = cx.watch<FilteredTasksCubit>().state.tasks;
          final tasksToDisplay = _getTasksToDisplay(
            filteredTasks: filteredTasks,
            unfilteredTasks: tasksState.tasks,
          );

          if (tasksState is TasksLoading) {
            return const _LoadingIndicator();
          }

          return SingleChildScrollView(
            child: Column(
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
            ),
          );
        },
      ),
    );
  }

  List<Task> _getTasksToDisplay({
    required List<Task> filteredTasks,
    required List<Task> unfilteredTasks,
  }) {
    final List<String> filteredTasksIds =
        filteredTasks.map((e) => e.id).toList();

    return filteredTasksIds.isEmpty
        ? unfilteredTasks
        : unfilteredTasks
            .where((e) => filteredTasksIds.contains(e.id))
            .toList();
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
