import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../common/presentation/page_layout.dart';
import '../../tasks/domain/use_cases/get_tasks_to_do.dart';
import '../../tasks/presentation/widgets/tasks_done_today.dart';
import '../../tasks/presentation/widgets/tasks_list.dart';
import '../../users/domain/use_cases/get_profile.dart';
import '../../users/presentation/cubit/profile_cubit.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      isFABHidden: false,
      isAppBarHidden: true,
      isDrawerHidden: false,
      areNumberAnimationsSuspended: false,
      child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
        listener: (context, authState) async {
          if (authState is Authenticated) {
            GetIt.I<GetProfile>()(userId: authState.user.id);
            GetIt.I<GetTasksToDo>()(userId: authState.user.id);
          }
        },
        builder: (context, authState) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              return Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (authState is Authenticated)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: const Avatar(radius: 75),
                        ),
                      if (profileState is ProfileLoaded) const TasksDoneToday(),
                    ],
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
