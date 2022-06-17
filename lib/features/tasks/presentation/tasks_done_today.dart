import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksDoneToday extends StatelessWidget {
  const TasksDoneToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksDoneTodayCubit, TasksDoneTodayState>(
      builder: (context, state) {
        const requiredTasksPerDay = 3;
        final tasksDoneAmount = state.tasks.length;
        final isStreakAchievedToday = tasksDoneAmount >= requiredTasksPerDay;
        final progressValue = isStreakAchievedToday ? 1.0 : tasksDoneAmount / requiredTasksPerDay;

        return Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Wins today: ${isStreakAchievedToday ? '' : tasksDoneAmount.toString()}'),
                    if (isStreakAchievedToday) const Icon(Icons.check),
                  ],
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: progressValue <= 0 ? 0.01 : progressValue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
