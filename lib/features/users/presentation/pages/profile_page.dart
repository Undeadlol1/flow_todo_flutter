import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/logout.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../common/presentation/page_layout.dart';
import '../../../goals/presentation/pages/goals_page.dart';
import '../widgets/avatar.dart';

class ProfilePage extends StatelessWidget {
  static const pathName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final today = DateTime.now();
          final streak = state.profile?.dailyStreak;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: Avatar(radius: 60)),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, GoalsPage.pathName),
                  child: const Text('Go to Goals'),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Debug information for developers:'),
              SelectableText(
                'Your user ID is: ${state.profile?.userId}',
              ),
              Text(
                'Is streak interrupted: ${streak?.isInterrupted().toString() ?? 'null value'}',
              ),
              Text('Today is: $today'),
              Text('Streak starts at: ${streak?.startsAt}'),
              Text(
                'Streak was updated at: ${state.profile?.dailyStreak.updatedAt}',
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () => GetIt.I<Logout>()(),
                  child: const Text('Logout'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
