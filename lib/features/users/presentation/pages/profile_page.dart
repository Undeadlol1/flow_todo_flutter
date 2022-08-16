import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/card_view.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/reset_experience_button.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentification/presentation/widgets/sign_out_button.dart';
import '../../../common/presentation/page_layout.dart';
import '../../../goals/presentation/pages/goals_page.dart';
import '../widgets/avatar.dart';

class ProfilePage extends StatelessWidget {
  static const pathName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
        builder: (context, authState) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              final today = DateTime.now();
              final streak = profileState.profile?.dailyStreak;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CardView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(child: Avatar(radius: 60)),
                        ),
                        if (authState is Authenticated)
                          Text(authState.user.displayName),
                      ],
                    ),
                  ),
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: const Text('Debug information for developers'),
                    children: [
                      SelectableText(
                        'Your user ID is: ${profileState.profile?.userId}',
                      ),
                      Text('Today is: $today'),
                      Text(
                        'Is streak interrupted: ${streak?.isInterrupted().toString() ?? 'null value'}',
                      ),
                      Text('Streak starts at: ${streak?.startsAt}'),
                      Text(
                        'Streak was updated at: ${profileState.profile?.dailyStreak.updatedAt}',
                      ),
                    ],
                  ),
                  const _Padding(),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, GoalsPage.pathName),
                    child: const Text('Go to Goals'),
                  ),
                  const _Padding(),
                  const SignOutButton(),
                  const _Padding(),
                  const Divider(),
                  const _Padding(),
                  Text(
                    'DANGER ZONE',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const _Padding(),
                  const Divider(),
                  const _Padding(),
                  const ResetExpereinceButton()
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _Padding extends StatelessWidget {
  const _Padding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
