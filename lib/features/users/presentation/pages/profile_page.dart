import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
