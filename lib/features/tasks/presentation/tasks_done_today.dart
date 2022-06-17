import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksDoneToday extends StatelessWidget {
  const TasksDoneToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksDoneTodayCubit, TasksDoneTodayState>(
      builder: (context, state) {
        return Column(
          children: [
            Text('Wins today: ${state.tasks.length.toString()}'),
          ],
        );
      },
    );
  }
}
