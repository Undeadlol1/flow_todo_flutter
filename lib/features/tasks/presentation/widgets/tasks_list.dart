import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final tasksState = context.watch<TasksCubit>();
        final filteredTasks = context.watch<FilteredTasksCubit>().state.tasks;
        final tasksToDisplay =
            filteredTasks.isEmpty ? tasksState.state.tasks : filteredTasks;

        if (tasksState is TasksLoading) {
          return const _LoadingIndicator();
        }

        return ListView.builder(
          itemCount: tasksToDisplay.length,
          itemBuilder: (BuildContext context, int index) {
            return TasksListItem(task: tasksToDisplay[index]);
          },
        );
      },
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
