import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';
import '../cubit/tasks_cubit.dart';
import 'filter_active_tasks.dart';
import 'tasks_list_item.dart';

class TasksList extends StatefulWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final _filteredTasksCubit = GetIt.I<FilteredTasksCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _filteredTasksCubit,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          builder: (cx) {
            final tasksState = cx.watch<TasksCubit>();
            final profileState = cx.watch<ProfileCubit>().state;
            final filteredTasks = cx.watch<FilteredTasksCubit>().state.tasks;

            if (tasksState is TasksLoading) {
              return const _LoadingIndicator();
            }

            final tasksToDisplay =
                filteredTasks.isEmpty ? tasksState.state.tasks : filteredTasks;

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (profileState is ProfileLoaded) const FilterActiveTasks(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tasksToDisplay.length,
                    itemBuilder: (_, index) {
                      return TasksListItem(task: tasksToDisplay[index]);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
