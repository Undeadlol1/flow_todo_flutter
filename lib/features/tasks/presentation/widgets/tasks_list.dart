import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../../common/presentation/widgets/pagination.dart';
import '../cubit/tasks_cubit.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  int _currentPage = 0;
  final int _tasksPerPage = 7;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, tasksState) {
        final tasksToDisplay = _getPaginatedTasksSlice(tasksState);

        if (tasksState is TasksLoading) {
          return const _LoadingIndicator();
        }

        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasksToDisplay.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TasksListItem(task: tasksToDisplay[index]),
                );
              },
            ),
            if (tasksState.tasks.isNotEmpty)
              Pagination(
                onPageChange: (newPageNumber) {
                  setState(() => _currentPage = newPageNumber);
                },
              ),
          ],
        );
      },
    );
  }

  List<Task> _getPaginatedTasksSlice(TasksState tasksState) {
    final sliceFrom = _currentPage * _tasksPerPage;
    final sliceTo = (_currentPage + 1) * _tasksPerPage;
    var totalAmountOfTasks = tasksState.tasks.length;
    return tasksState.tasks
        .getRange(
          sliceFrom,
          sliceTo > totalAmountOfTasks ? totalAmountOfTasks : sliceTo,
        )
        .toList();
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
