import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/worked_on_tasks_days_in_a_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';
import 'wins_today_text.dart';

class TasksWorkedOnToday extends StatefulWidget {
  const TasksWorkedOnToday({Key? key}) : super(key: key);

  @override
  State<TasksWorkedOnToday> createState() => _TasksWorkedOnTodayState();
}

class _TasksWorkedOnTodayState extends State<TasksWorkedOnToday>
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
        return BlocConsumer<TasksWorkedOnTodayCubit, TasksWorkedOnTodayState>(
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
                children: [
                  const WinsTodayText(),
                  _ProgressBar(
                    animation: _animation,
                    animationController: _animationController,
                  ),
                  WorkedOnTasksDaysInARow(
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
    required TasksWorkedOnTodayState tasksDoneTodayState,
  }) {
    if (!mounted) return;

    final tasksDoneAmount = tasksDoneTodayState.tasks.length;
    final progressValue = _getProgressValue(
      tasksDoneAmount: tasksDoneAmount,
      requiredTasksPerDay: dailyStreak?.perDay ?? 1,
    );
    _animation = Tween<double>(
      end: progressValue,
      begin: previousProgressValue,
    ).animate(_animationController);

    tasksDoneTodayState.whenOrNull(
      loaded: (_) {
        Future.microtask(() {
          _hasFirstAnimationForcefullyRan = true;

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
    if (tasksDoneAmount == 0) return 0;
    final remainder = tasksDoneAmount.remainder(requiredTasksPerDay);
    return remainder == 0 ? 1 : remainder / requiredTasksPerDay;
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
    required this.animation,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: LinearProgressIndicator(
        value: animation.value <= 0 ? 0.01 : animation.value,
      ),
    );
  }
}
