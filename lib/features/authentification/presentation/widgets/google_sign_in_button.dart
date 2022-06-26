import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/use_cases/sign_in_with_google.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({Key? key}) : super(key: key);
  final SignInWithGoogle _signInWithGoogle = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _signInWithGoogle,
      child: const Text('Sign in with Google'),
    );
  }
}
