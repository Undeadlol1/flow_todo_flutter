import 'tasks_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/tasks_cubit.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.tasks.length,
          itemBuilder: (_, index) {
            return TasksListItem(task: state.tasks[index]);
          },
        );
      },
    );
  }
}
