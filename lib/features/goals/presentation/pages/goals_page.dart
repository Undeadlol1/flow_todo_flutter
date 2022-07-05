import 'package:flow_todo_flutter_2022/features/goals/domain/use_cases/get_goals.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/widgets/upsert_goal_form.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/create_task_fab.dart';
import 'package:get_it/get_it.dart';

import '../../../users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/page_layout.dart';

class GoalsPage extends StatelessWidget {
  static const pathName = '/goals';
  final GetGoals getGoals = GetIt.I();
  GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isAppBarHidden: true,
      isDrawerHidden: false,
      isNumbersAnimationSuspended: false,
      floatingActionButton: const CreateTaskFAB(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, profileState) async {
          if (ProfileCubit is ProfileLoaded) {
            getGoals(userId: profileState.profile!.id);
          }
        },
        builder: (context, profileState) {
          return Column(
            children: [
              if (profileState is ProfileLoaded) const UpsertGoalForm(),
              const Expanded(
                child: _GoalsList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GoalsList extends StatelessWidget {
  const _GoalsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('SOmething')],
    );
    // return ListView.builder(
    //   itemCount: tasksState.tasks.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return TasksListItem(task: tasksState.tasks[index]);
    //   },
    // );
  }
}
