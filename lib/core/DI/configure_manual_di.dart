import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';

import '../../features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import '../../features/common/domain/use_cases/go_to_main_page.dart';
import '../../features/leveling/domain/entities/default_leveling_config.dart';
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart';
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import '../../features/tasks/domain/services/stale_task_detector.dart';
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart';

void configureManualDI() {
  final injector = GetIt.I;

  injector.registerFactory(() => FirebaseFirestore.instance);
  injector.registerFactory(() => firebase_auth.FirebaseAuth.instance);
  injector.registerSingleton(BuildContextProvider());
  injector.registerSingleton(
    ExperienceToReachNextLevelCalculator(
      levelingConfig: DefaultLevelingConfig(),
    ),
  );
  injector.registerSingleton(NextRepetitionCalculator());
  injector.registerSingleton(GoToMainPage(contextProvider: injector.get()));
  injector.registerSingleton(GoToTaskCreation(contextProvider: injector.get()));
  injector.registerSingleton(SignInWithGoogle(firebaseAuth: injector.get()));
  injector.registerSingleton(StaleTaskDetector());
}
