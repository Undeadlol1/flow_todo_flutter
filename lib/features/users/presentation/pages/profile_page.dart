import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../../common/presentation/page_layout.dart';
import '../../../goals/presentation/pages/goals_page.dart';

class ProfilePage extends StatelessWidget {
  static const pathName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return ProfileScreen(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, GoalsPage.pathName),
                  child: const Text('Go to Goals'),
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final today = DateTime.now();
                  final streak = state.profile?.dailyStreak;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  );
                },
              ),
            ],
          );
        } else {
          return PageLayout(
            child: Center(
              child: SizedBox(
                height: 500,
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(height: 250),
                  child: const SignInScreen(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
