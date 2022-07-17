import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/create_task_fab.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/tasks_done_today.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../features/authentification/presentation/cubit/authentification_cubit.dart';
import '../../../features/authentification/presentation/widgets/google_sign_in_button.dart';
import '../../../features/common/presentation/page_layout.dart';
import '../../../features/quests/presentation/widgets/active_quest.dart';
import '../../../features/tasks/domain/use_cases/get_tasks_done_today.dart';
import '../../../features/tasks/domain/use_cases/get_tasks_to_do.dart';
import '../../../features/tasks/presentation/widgets/tasks_list.dart';
import '../../../features/users/domain/use_cases/get_profile.dart';
import '../../../features/users/presentation/cubit/profile_cubit.dart';
import '../../../features/users/presentation/widgets/avatar.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return PageLayout(
          isAppBarHidden: true,
          isDrawerHidden: false,
          isNumbersAnimationSuspended: false,
          floatingActionButton:
              profileState is ProfileLoaded ? const CreateTaskFAB() : null,
          child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
            listener: (context, authState) async {
              if (authState is Authenticated) {
                GetIt.I<GetProfile>()(userId: authState.user.id);
                GetIt.I<GetTasksToDo>()(userId: authState.user.id);
                GetIt.I<GetTasksDoneToday>()(userId: authState.user.id);
              }
            },
            builder: (context, authState) {
              if (authState is NotAuthenticated) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Please sign in to play the game:'),
                      const SizedBox(height: 10),
                      GoogleSignInButton(),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  if (profileState is ProfileLoaded)
                    const Expanded(
                      flex: 1,
                      child: _ProgressSummaryCard(),
                    ),
                  const Expanded(
                    flex: 3,
                    child: TasksList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ProgressSummaryCard extends StatelessWidget {
  const _ProgressSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const contraints = BoxConstraints.tightForFinite(width: 220);
    return Card(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Avatar(radius: 60),
          ),
          Column(
            children: [
              ConstrainedBox(
                constraints: contraints,
                child: ActiveQuest(),
              ),
              ConstrainedBox(
                constraints: contraints,
                child: const TasksDoneToday(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
