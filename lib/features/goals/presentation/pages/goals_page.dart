import '../../../tasks/presentation/widgets/tasks_done_today.dart';
import '../../../users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/page_layout.dart';

class GoalsPage extends StatelessWidget {
  static const pathName = '/goals';
  const GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isFABHidden: false,
      isAppBarHidden: true,
      isDrawerHidden: false,
      isNumbersAnimationSuspended: false,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, authState) async {
          // if (authState is Authenticated) {
          // GetIt.I<GetProfile>()(userId: authState.user.id);
          // GetIt.I<GetTasksToDo>()(userId: authState.user.id);
          // GetIt.I<GetTasksDoneToday>()(userId: authState.user.id);
          // }
        },
        builder: (context, profileState) {
          return Column(
            children: [
              if (profileState is ProfileLoaded)
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [TasksDoneToday()],
                  ),
                ),
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
