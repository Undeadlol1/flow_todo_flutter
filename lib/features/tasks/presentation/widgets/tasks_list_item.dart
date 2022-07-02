import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final cubit = GetIt.instance<ProfileCubit>();
        cubit.setProfile(
          cubit.state.profile!.copyWith(
              experience: (cubit.state.profile?.experience ?? 0) + 50),
        );
        // GetIt.instance<GoToTaskPage>()(task: task);
      },
      child: Row(
        children: [
          Flexible(
            child: Text(task.title),
          ),
        ],
      ),
    );
  }
}
