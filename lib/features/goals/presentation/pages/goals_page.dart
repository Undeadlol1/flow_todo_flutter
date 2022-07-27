import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/use_cases/get_goals.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/use_cases/make_step_forward_on_a_goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/player_progress_summary.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/page_layout.dart';
import '../widgets/create_goal_fab.dart';

class GoalsPage extends StatefulWidget {
  static const pathName = '/goals';

  const GoalsPage({Key? key}) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final GetGoals _getGoals = GetIt.I();

  @override
  void initState() {
    super.initState();

    _getGoals(userId: FirebaseAuth.instance.currentUser?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isAppBarHidden: false,
      isDrawerHidden: true,
      isNumbersAnimationSuspended: true,
      floatingActionButton: CreateGoalFAB(),
      child: Column(
        children: [
          const PlayerProgressSummary(),
          Expanded(child: _GoalsList()),
        ],
      ),
    );
  }
}

class _GoalsList extends StatelessWidget {
  _GoalsList({Key? key}) : super(key: key);
  final MakeStepForwardOnAGoal makeStepForwardOnAGoal = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      buildWhen: _buildWhen,
      builder: (context, goalsState) {
        return goalsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (_) {
            return ListView.builder(
              itemCount: goalsState.goals.length,
              itemBuilder: (BuildContext context, int index) {
                final goal = goalsState.goals[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(goal.title),
                    ),
                    AnimatedNumbers(number: goal.points),
                    IconButton(
                      onPressed: () => makeStepForwardOnAGoal(goal),
                      icon: const Icon(Icons.add),
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  // TODO https://github.com/felangel/bloc/issues/1144#issuecomment-625803682
  bool _buildWhen(GoalsState previous, GoalsState current) {
    if (previous.goals.isEmpty || current.goals.isEmpty) return true;

    if (previous.goals.length != current.goals.length) return true;

    final int combinedPointsOfPreviousState =
        previous.goals.reduce((previous, next) {
      return previous.copyWith(points: next.points + previous.points);
    }).points;
    final int combinedPointsOfNextState =
        current.goals.reduce((previous, next) {
      return previous.copyWith(points: next.points + previous.points);
    }).points;
    return combinedPointsOfNextState > combinedPointsOfPreviousState;
  }
}
