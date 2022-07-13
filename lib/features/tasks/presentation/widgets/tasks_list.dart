import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';

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
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, tasksState) {
        if (tasksState is TasksLoading) {
          return const _LoadingIndicator();
        }

        return ListView.builder(
          itemCount: tasksState.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return TasksListItem(task: tasksState.tasks[index]);
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
      child: SizedBox(
        height: 550,
        child: LoadingIndicator(
          size: 50,
          borderWidth: 1,
        ),
      ),
    );
  }
}
