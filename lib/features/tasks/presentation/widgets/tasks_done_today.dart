import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
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

  static const _padding = EdgeInsets.only(
    top: 12,
    left: 16,
    right: 16,
    bottom: 4,
  );

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
    return Builder(
      builder: (context) {
        final ProfileState profileState = context.watch<ProfileCubit>().state;
        return BlocConsumer<TasksDoneTodayCubit, TasksDoneTodayState>(
          listener: (context, tasksDoneState) {
            _runProgressAnimation(
              context: context,
              tasksDoneTodayState: tasksDoneState,
              dailyStreak: profileState.profile?.dailyStreak,
            );
          },
          builder: (context, tasksDoneState) {
            final int requiredTasksPerDay =
                profileState.profile?.dailyStreak.perDay ?? 1;
            final tasksDoneAmount = tasksDoneState.tasks.length;
            final isStreakAchievedToday =
                tasksDoneAmount >= requiredTasksPerDay;
            previousProgressValue = _getProgressValue(
              tasksDoneAmount: tasksDoneAmount,
              requiredTasksPerDay: requiredTasksPerDay,
            );

            if (_hasFirstAnimationForcefullyRan == false) {
              _runProgressAnimation(
                context: context,
                tasksDoneTodayState: tasksDoneState,
                dailyStreak: profileState.profile?.dailyStreak,
              );
            }

            return Padding(
              padding: _padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _WinsTodayText(
                    tasksDoneState: tasksDoneState,
                    tasksDoneAmount: tasksDoneAmount,
                    requiredTasksPerDay: requiredTasksPerDay,
                    isStreakAchievedToday: isStreakAchievedToday,
                  ),
                  _ProgressBar(
                    animationController: _animationController,
                    isStreakAchievedToday: isStreakAchievedToday,
                    animation: _animation,
                  ),
                  _DaysInARowText(
                    areAnimationsEnabled: _hasFirstAnimationForcefullyRan,
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
    required BuildContext context,
    required DailyStreak? dailyStreak,
    required TasksDoneTodayState tasksDoneTodayState,
  }) {
    final tasksDoneAmount = tasksDoneTodayState.tasks.length;

    if (!mounted) return;
    if (tasksDoneAmount > (dailyStreak?.perDay ?? 1)) return;

    final double progressValue = _getProgressValue(
      tasksDoneAmount: tasksDoneAmount,
      requiredTasksPerDay: dailyStreak?.perDay ?? 1,
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

class _DaysInARowText extends StatelessWidget {
  final bool areAnimationsEnabled;
  const _DaysInARowText({
    Key? key,
    required this.areAnimationsEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final ProfileState profileState = context.watch<ProfileCubit>().state;

        final dailyStreak = profileState.profile?.dailyStreak;
        final int daysInARow = dailyStreak?.isInterrupted() ?? true
            ? 0
            : dailyStreak?.getDaysInARow() ?? 0;

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
                  areNumberAnimationsSuspended: !areAnimationsEnabled,
                ),
            ],
          ),
        );
      },
    );
  }
}

// TODO make this reusable?
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
    required this.animation,
    required this.animationController,
    required this.isStreakAchievedToday,
  }) : super(key: key);

  final AnimationController animationController;
  final bool isStreakAchievedToday;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: animationController.isAnimating || !isStreakAchievedToday,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          child: LinearProgressIndicator(
            value: animation.value <= 0 ? 0.01 : animation.value,
          ),
        ),
      ),
    );
  }
}

class _WinsTodayText extends StatelessWidget {
  const _WinsTodayText({
    Key? key,
    required this.isStreakAchievedToday,
    required this.tasksDoneAmount,
    required this.requiredTasksPerDay,
    required this.tasksDoneState,
  }) : super(key: key);

  final TasksDoneTodayState tasksDoneState;
  final bool isStreakAchievedToday;
  final int tasksDoneAmount;
  final int requiredTasksPerDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        if (isStreakAchievedToday) const Icon(Icons.check, size: 16),
      ],
    );
  }
}
