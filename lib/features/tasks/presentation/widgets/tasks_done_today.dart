import 'dart:developer';

import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';

class TasksDoneToday extends StatefulWidget {
  const TasksDoneToday({Key? key}) : super(key: key);

  @override
  State<TasksDoneToday> createState() => _TasksDoneTodayState();
}

class _TasksDoneTodayState extends State<TasksDoneToday>
    with TickerProviderStateMixin {
  bool _isAnimationListenerAdded = false;
  bool _hasFirstAnimationForcefullyRan = false;
  double previousProgressValue = 0;
  late Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      end: 0,
      begin: 0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return BlocConsumer<TasksDoneTodayCubit, TasksDoneTodayState>(
          listener: ((context, tasksDoneState) {
            final int requiredTasksPerDay =
                profileState.profile?.dailyStreak.perDay ?? 1;
            final tasksDoneAmount = tasksDoneState.tasks.length;
            _runAnimation(
              context: context,
              tasksDoneAmount: tasksDoneAmount,
              tasksDoneTodayState: tasksDoneState,
              requiredTasksPerDay: requiredTasksPerDay,
            );
          }),
          builder: (context, tasksDoneState) {
            final int requiredTasksPerDay =
                profileState.profile?.dailyStreak.perDay ?? 1;
            final tasksDoneAmount = tasksDoneState.tasks.length;
            final isStreakAchievedToday =
                tasksDoneAmount >= requiredTasksPerDay;
            final progressValue = isStreakAchievedToday
                ? 1.0
                : tasksDoneAmount / requiredTasksPerDay;

            previousProgressValue = progressValue;

            log('animation.value: ${_animation.value.toString()}');

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
                          value:
                              _animation.value <= 0 ? 0.01 : _animation.value,
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

  void _runAnimation({
    required int tasksDoneAmount,
    required BuildContext context,
    required int requiredTasksPerDay,
    required TasksDoneTodayState tasksDoneTodayState,
  }) {
    if (!mounted) return;
    final isStreakAchievedToday = tasksDoneAmount >= requiredTasksPerDay;
    final progressValue =
        isStreakAchievedToday ? 1.0 : tasksDoneAmount / requiredTasksPerDay;
    tasksDoneTodayState.when(
      loading: () {},
      loaded: (loadedTasksState) {
        Future.microtask(() {
          _hasFirstAnimationForcefullyRan = true;

          _animation = Tween<double>(
            end: progressValue,
            begin: previousProgressValue,
          ).animate(_animationController);

          if (_isAnimationListenerAdded == false) {
            _animation.addListener(() => setState(() {}));
            _isAnimationListenerAdded = true;
          }

          _animationController
            ..reset()
            ..forward();
        });
      },
    );
  }
}
