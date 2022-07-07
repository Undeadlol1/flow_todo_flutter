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
            _runProgressAnimation(
              context: context,
              tasksDoneAmount: tasksDoneAmount,
              tasksDoneTodayState: tasksDoneState,
              requiredTasksPerDay: requiredTasksPerDay,
            );
          }),
          builder: (context, tasksDoneState) {
            final dailyStreak = profileState.profile?.dailyStreak;
            final int requiredTasksPerDay =
                profileState.profile?.dailyStreak.perDay ?? 1;
            final tasksDoneAmount = tasksDoneState.tasks.length;
            final isStreakAchievedToday =
                tasksDoneAmount >= requiredTasksPerDay;
            final int daysInARow = dailyStreak?.isBroken() ?? false
                ? 0
                : dailyStreak?.getDaysInARow() ?? 0;

            previousProgressValue = _getProgressValue(
              requiredTasksPerDay: requiredTasksPerDay,
              tasksDoneAmount: tasksDoneAmount,
            );

            if (_hasFirstAnimationForcefullyRan == false) {
              _runProgressAnimation(
                tasksDoneAmount: tasksDoneAmount,
                context: context,
                requiredTasksPerDay: requiredTasksPerDay,
                tasksDoneTodayState: tasksDoneState,
              );
            }

            return Padding(
              padding: const EdgeInsets.only(
                top: 12,
                right: 16,
                left: 16,
                bottom: 4,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Wins today: '),
                          tasksDoneState.maybeMap(
                            loaded: (value) => Visibility(
                              visible: !isStreakAchievedToday,
                              child: Row(
                                children: [
                                  AnimatedNumbers(number: tasksDoneAmount),
                                  Text(' / $requiredTasksPerDay'),
                                ],
                              ),
                            ),
                            orElse: () => const SizedBox(),
                          ),
                          if (isStreakAchievedToday)
                            const Icon(Icons.check, size: 16),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _animationController.isAnimating ||
                        !isStreakAchievedToday,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: LinearProgressIndicator(
                        value: _animation.value <= 0 ? 0.01 : _animation.value,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Won days in a row: '),
                      if (profileState is ProfileLoaded)
                        AnimatedNumbers(
                          number: daysInARow,
                          duration: const Duration(milliseconds: 200),
                          areNumberAnimationsSuspended:
                              !_hasFirstAnimationForcefullyRan,
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _runProgressAnimation({
    required int tasksDoneAmount,
    required BuildContext context,
    required int requiredTasksPerDay,
    required TasksDoneTodayState tasksDoneTodayState,
  }) {
    if (!mounted) return;
    if (tasksDoneAmount > requiredTasksPerDay) return;

    final double progressValue = _getProgressValue(
      tasksDoneAmount: tasksDoneAmount,
      requiredTasksPerDay: requiredTasksPerDay,
    );

    tasksDoneTodayState.when(
      loading: () {},
      loaded: (_) {
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

  double _getProgressValue({
    required int tasksDoneAmount,
    required int requiredTasksPerDay,
  }) {
    final isStreakAchievedToday = tasksDoneAmount >= requiredTasksPerDay;
    return isStreakAchievedToday ? 1.0 : tasksDoneAmount / requiredTasksPerDay;
  }
}
