import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithGoogle {
  final FirebaseAuth firebaseAuth;
  const SignInWithGoogle({required this.firebaseAuth});

  Future<UserCredential> call() async {
    return _triggerGoogleAuthFlow()
        .then(_getGoogleAuthDetails)
        .then(_signInToFirebaseAuthViaGoogleCredentials);
  }

  FutureOr<UserCredential> _signInToFirebaseAuthViaGoogleCredentials(
    googleAuth,
  ) {
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );

    return firebaseAuth.signInWithCredential(credential);
  }

  FutureOr<GoogleSignInAuthentication?> _getGoogleAuthDetails(
    GoogleSignInAccount? googleUser,
  ) {
    return googleUser?.authentication;
  }

  Future<GoogleSignInAccount?> _triggerGoogleAuthFlow() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    return googleUser;
  }
}
