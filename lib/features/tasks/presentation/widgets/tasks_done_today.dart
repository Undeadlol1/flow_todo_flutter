import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';

class TasksDoneToday extends StatelessWidget {
  const TasksDoneToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<TasksDoneTodayCubit, TasksDoneTodayState>(
          builder: (context, tasksDoneState) {
            final int requiredTasksPerDay =
                profileState.profile?.dailyStreak.perDay ?? 1;
            final tasksDoneAmount = tasksDoneState.tasks.length;
            final isStreakAchievedToday =
                tasksDoneAmount >= requiredTasksPerDay;
            final progressValue = isStreakAchievedToday
                ? 1.0
                : tasksDoneAmount / requiredTasksPerDay;

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Tasks done today: '),
                            Visibility(
                              visible: !isStreakAchievedToday,
                              child: Row(
                                children: [
                                  AnimatedNumbers(number: tasksDoneAmount),
                                  Text(' / $requiredTasksPerDay'),
                                ],
                              ),
                            ),
                            if (isStreakAchievedToday)
                              const Icon(Icons.check, size: 16),
                          ],
                        )
                      ],
                    ),
                    Visibility(
                      visible: !isStreakAchievedToday,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: LinearProgressIndicator(
                          value: progressValue <= 0 ? 0.01 : progressValue,
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: const [
                    //     Text('Won days in a row: '),
                    //     AnimatedNumbers(number: 0),
                    //   ],
                    // )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
