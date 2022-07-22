import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/use_cases/get_goals.dart';
import 'package:flow_todo_flutter_2022/features/goals/domain/use_cases/make_step_forward_on_a_goal.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/widgets/upsert_goal_form.dart';
import 'package:get_it/get_it.dart';

import '../../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../../users/domain/use_cases/get_profile.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/page_layout.dart';
import '../widgets/create_goal_fab.dart';

class GoalsPage extends StatelessWidget {
  static const pathName = '/goals';
  final GetGoals _getGoals = GetIt.I();
  GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<GoalsCubit>(),
      child: PageLayout(
        isAppBarHidden: true,
        isDrawerHidden: false,
        isNumbersAnimationSuspended: false,
        floatingActionButton: CreateGoalFAB(),
        child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
          listener: (context, authState) async {
            if (authState is Authenticated) {
              // TODO this is duplicate
              GetIt.I<GetProfile>()(userId: authState.user.id);
            }
          },
          builder: (context, authState) {
            return BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, profileState) async {
                if (profileState is ProfileLoaded) {
                  return _getGoals(userId: profileState.profile!.id);
                }
              },
              builder: (context, profileState) {
                return Column(
                  children: [

                    const Expanded(child: _GoalsList()),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _GoalsList extends StatelessWidget {
  const _GoalsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      builder: (context, goalsState) {
        return goalsState.map(
          loading: (value) => const SizedBox(),
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
                      onPressed: () => GetIt.I<MakeStepForwardOnAGoal>()(goal),
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
}
