import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../../common/presentation/widgets/pagination.dart';
import '../cubit/tasks_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, tasksState) {
        if (tasksState is TasksLoading) {
          return const _LoadingIndicator();
        }
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasksState.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TasksListItem(task: tasksState.tasks[index]),
                );
              },
            ),
            if (tasksState.tasks.isNotEmpty)
              Pagination(
                onPageChange: (newPageNumber) {},
              ),
          ],
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
