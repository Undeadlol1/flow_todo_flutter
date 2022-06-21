import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../common/presentation/page_layout_and_dependencies.dart';
import '../../tasks/domain/use_cases/get_tasks_to_do.dart';
import '../../tasks/presentation/widgets/tasks_done_today.dart';
import '../../tasks/presentation/widgets/tasks_list.dart';
import '../../users/domain/use_cases/get_profile.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayoutAndDependencies(
      isFABHidden: false,
      isDrawerHidden: false,
      child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
        listener: (context, authState) async {
          if (authState is Authenticated) {
            GetIt.I<GetProfile>()(userId: authState.user.id);
            GetIt.I<GetTasksToDo>()(userId: authState.user.id);
          }
        },
        builder: (context, authState) {
          return Column(
            children: [
              if (authState is Authenticated) const TasksDoneToday(),
              if (authState is NotAuthenticated)
                const SizedBox(
                  height: 500,
                  child: Center(
                    child: GoogleSignInButton(),
                  ),
                ),
              const TasksList(),
            ],
          );
        },
      ),
    );
  }
}
