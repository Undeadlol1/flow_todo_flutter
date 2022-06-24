import 'package:flow_todo_flutter_2022/features/tasks/domain/models/task.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TasksListItem extends StatelessWidget {
  final Task task;
  const TasksListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final cubit = GetIt.I<ProfileCubit>();
        final profile = cubit.state.profile;
        cubit.setProfile(
          profile!.copyWith(
            points: profile.points + 50,
            experience: profile.experience! + 50,
          ),
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
