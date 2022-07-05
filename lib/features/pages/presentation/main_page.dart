import 'package:flow_todo_flutter_2022/features/goals/presentation/widgets/create_goal_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../authentification/presentation/widgets/google_sign_in_button.dart';
import '../../common/presentation/page_layout.dart';
import '../../tasks/domain/use_cases/get_tasks_done_today.dart';
import '../../tasks/domain/use_cases/get_tasks_to_do.dart';
import '../../tasks/presentation/widgets/tasks_done_today.dart';
import '../../tasks/presentation/widgets/tasks_list.dart';
import '../../users/domain/use_cases/get_profile.dart';
import '../../users/presentation/cubit/profile_cubit.dart';
import '../../users/presentation/widgets/avatar.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isAppBarHidden: true,
      isDrawerHidden: false,
      isNumbersAnimationSuspended: false,
      floatingActionButton: CreateGoalFAB(),
      child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
        listener: (context, authState) async {
          if (authState is Authenticated) {
            GetIt.I<GetProfile>()(userId: authState.user.id);
            GetIt.I<GetTasksToDo>()(userId: authState.user.id);
            GetIt.I<GetTasksDoneToday>()(userId: authState.user.id);
          }
        },
        builder: (context, authState) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              return Column(
                children: [
                  if (profileState is ProfileLoaded)
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (authState is Authenticated)
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: const Avatar(radius: 60),
                            ),
                          const TasksDoneToday(),
                        ],
                      ),
                    ),
                  const Expanded(
                    child: TasksList(),
                  ),
                  if (authState is NotAuthenticated)
                    SizedBox(
                      height: 500,
                      child: Center(
                        child: GoogleSignInButton(),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
