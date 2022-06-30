import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../../common/presentation/page_layout.dart';

class ProfilePage extends StatelessWidget {
  static const pathName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasData) {
          return const ProfileScreen();
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
