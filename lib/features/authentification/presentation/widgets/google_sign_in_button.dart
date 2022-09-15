import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/use_cases/sign_in_with_google.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isLoadingANimationVisible = false;
  static final SignInWithGoogle _signInWithGoogle = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_isLoadingANimationVisible) {
          return;
        }

        setState(() => _isLoadingANimationVisible = true);
        _signInWithGoogle();
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _isLoadingANimationVisible
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              )
            : const Text('Sign in with Google'),
      ),
    );
  }
}
