import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/pagination.dart';

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
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.tasks.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TasksListItem(task: state.tasks[index]),
                );
              },
            ),
            Pagination(
              onPageChange: (newPageNumber) {},
            ),
          ],
        );
      },
    );
  }
}
