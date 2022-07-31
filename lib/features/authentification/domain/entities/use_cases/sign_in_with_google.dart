import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_todo_flutter_2022/core/services/use_case_exception_handler.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/streaks/domain/models/daily_streak.dart';
import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/data/upsert_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/models/profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithGoogle {
  final FirebaseAuth firebaseAuth;
  final ProfileCubit profileCubit;
  final UniqueIdGenerator uniqueIdGenerator;
  final GetProfileRepository getProfileRepository;
  final UpsertProfileRepository upsertProfileRepository;
  final UseCaseExceptionHandler useCaseExceptionHandler;
  const SignInWithGoogle({
    required this.profileCubit,
    required this.firebaseAuth,
    required this.uniqueIdGenerator,
    required this.getProfileRepository,
    required this.upsertProfileRepository,
    required this.useCaseExceptionHandler,
  });

  Future<UserCredential?> call() async {
    try {
      return await _triggerGoogleAuthFlow()
          .then(_getGoogleAuthDetails)
          .then(_signInToFirebaseAuthViaGoogleCredentials)
          .then(_createProfileIfUserDoesntHaveOne);
    } catch (e) {
      useCaseExceptionHandler.handleException(e);
    }
    return null;
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

  FutureOr<UserCredential> _createProfileIfUserDoesntHaveOne(
    userCredential,
  ) async {
    final userId = userCredential.user!.uid;
    final viewerFirestoreProfile = await getProfileRepository(userId: userId);

    if (viewerFirestoreProfile == null) {
      profileCubit.setProfile(await _createProfileAndUpdateState(userId));
    }

    return userCredential;
  }

  Future<Profile> _createProfileAndUpdateState(userId) async {
    final today = DateTime.now();
    final profileToCreate = Profile(
      points: 0,
      id: userId,
      experience: 0,
      userId: userId,
      areEcouragingMessagesDisabled: false,
      createdAt: today.millisecondsSinceEpoch,
      dailyStreak: DailyStreak(
        perDay: 3,
        userId: userId,
        startsAt: today,
        createdAt: today,
        id: uniqueIdGenerator(),
      ),
    );

    await upsertProfileRepository(profileToCreate);

    return profileToCreate;
  }
}
