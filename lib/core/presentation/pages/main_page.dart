import 'package:flow_todo_flutter_2022/core/remote_config/domain/use_cases/get_remote_config.dart';
import 'package:flow_todo_flutter_2022/features/analytics/data/traces/navigation_to_filter_page_trace.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/create_task_fab.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/widgets/selected_tasks.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/player_progress_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../features/authentification/presentation/cubit/authentification_cubit.dart';
import '../../../features/authentification/presentation/widgets/google_sign_in_button.dart';
import '../../../features/common/presentation/page_layout.dart';
import '../../../features/quests/domain/use_cases/get_active_quests.dart';
import '../../../features/tasks/domain/use_cases/get_tasks_worked_on_today.dart';
import '../../../features/tasks/domain/use_cases/get_tasks_to_do.dart';
import '../../../features/tasks/presentation/pages/filter_tasks_page.dart';
import '../../../features/tasks/presentation/widgets/tasks_list.dart';
import '../../../features/users/domain/use_cases/get_profile.dart';
import '../../../features/users/presentation/cubit/profile_cubit.dart';

class MainPage extends StatelessWidget {
  static const pathName = '/main';

  const MainPage({Key? key}) : super(key: key);

  @override
  build(context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        final isProfileLoaded = profileState is ProfileLoaded;
        return PageLayout(
          isAppBarHidden: true,
          isDrawerHidden: true,
          isNumbersAnimationSuspended: false,
          floatingActionButton: isProfileLoaded ? const CreateTaskFAB() : null,
          child: BlocConsumer<AuthentificationCubit, AuthentificationState>(
            listener: (context, authState) async {
              await GetIt.I<GetRemoteConfig>()();

              if (authState is Authenticated) {
                final userId = authState.user.id;
                GetIt.I<GetProfile>()(userId: userId);
                GetIt.I<GetTasksToDo>()(userId: userId);
                GetIt.I<GetActiveQuests>()(userId: userId);
                GetIt.I<GetTasksWorkedOnToday>()(userId: userId);
              }
            },
            builder: (context, authState) {
              if (authState is NotAuthenticated) {
                return const _LoginScreen();
              }

              return Column(
                children: [
                  if (profileState is ProfileLoaded)
                    const Expanded(
                      flex: 1,
                      child: PlayerProgressSummary(),
                    ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      primary: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SelectedTasks(),
                          TextButton(
                            onPressed: () async {
                              await GetIt.I<NavigationToFilterPageTrace>()
                                  .start();

                              // ignore: use_build_context_synchronously
                              Navigator.of(context)
                                  .pushNamed(FilterTasksPage.pathName);
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.manage_search),
                                SizedBox(width: 10),
                                Text('Filter tasks'),
                              ],
                            ),
                          ),
                          const CardView(child: TasksList()),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (kReleaseMode)
            Image.network(
              'https://media.giphy.com/media/dzaUX7CAG0Ihi/giphy.gif',
            ),
          const SizedBox(height: 10),
          const Text('Please sign in to start:'),
          const SizedBox(height: 10),
          GoogleSignInButton(),
        ],
      ),
    );
  }
}
