import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';
import '../../../common/presentation/widgets/animated_numbers.dart';
import '../../../streaks/domain/services/streak_days_in_a_row_calculator.dart';

class WorkedOnTasksDaysInARow extends StatelessWidget {
  final bool areAnimationsEnabled;
  final StreakDaysInARowCalculator streakDaysInARowCalculator = GetIt.I();
  WorkedOnTasksDaysInARow({
    Key? key,
    required this.areAnimationsEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        final dailyStreak = profileState.profile.dailyStreak;
        final int daysInARow = dailyStreak.isInterrupted()
            ? 0
            : streakDaysInARowCalculator(
                updatedAt: dailyStreak.updatedAt,
                startsAt: dailyStreak.startsAt,
              );

        return Visibility(
          visible: daysInARow > 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Won days in a row: '),
              if (profileState is ProfileLoaded)
                AnimatedNumbers(
                  number: daysInARow,
                  duration: const Duration(milliseconds: 200),
                  isAnimationSuspended: !areAnimationsEnabled,
                ),
            ],
          ),
        );
      },
    );
  }
}
