import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/use_cases/sign_in_with_google.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Sign in with Google'),
      onPressed: () => GetIt.I<SignInWithGoogle>()(),
    );
  }
}
