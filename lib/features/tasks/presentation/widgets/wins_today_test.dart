import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/animated_numbers.dart';
import '../cubit/tasks_done_today_cubit.dart';

class WinsTodayText extends StatelessWidget {
  const WinsTodayText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final profileState = context.watch<ProfileCubit>().state;
        final tasksDoneState = context.watch<TasksDoneTodayCubit>().state;

        final tasksDoneAmount = tasksDoneState.tasks.length;
        final requiredTasksPerDay =
            profileState.profile?.dailyStreak.perDay ?? 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Wins today: '),
            tasksDoneState.maybeMap(
              loaded: (value) => Row(
                children: [
                  AnimatedNumbers(number: tasksDoneAmount),
                  Text(
                    tasksDoneAmount >= requiredTasksPerDay
                        ? ' '
                        : ' / $requiredTasksPerDay',
                  ),
                  if (tasksDoneAmount >= requiredTasksPerDay)
                    Icon(
                      Icons.check,
                      size: 22,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  if (tasksDoneAmount >= (requiredTasksPerDay * 2))
                    Text(
                      ' x${(tasksDoneAmount - tasksDoneAmount.remainder(requiredTasksPerDay)) ~/ requiredTasksPerDay}',
                    ),
                ],
              ),
              orElse: () => const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}