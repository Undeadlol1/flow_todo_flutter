import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';

import '../../features/leveling/domain/entities/default_leveling_config.dart';
import '../../features/leveling/domain/services/experience_to_reach_next_level_calculator.dart';
import '../../features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import '../../features/tasks/domain/use_cases/go_to_task_creation.dart';

void configureManualDI() {
  final injector = GetIt.I;

  injector.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);
  injector.registerFactory<firebase_auth.FirebaseAuth>(
    () => firebase_auth.FirebaseAuth.instance,
  );
  injector.registerFactory<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  injector
      .registerFactory<FirebaseCrashlytics>(() => FirebaseCrashlytics.instance);
  injector.registerSingleton(BuildContextProvider());
  injector.registerSingleton(
    ExperienceToReachNextLevelCalculator(
      levelingConfig: DefaultLevelingConfig(),
    ),
  );
  injector.registerSingleton(NextRepetitionCalculator());
  injector.registerSingleton(GoToTaskCreation(contextProvider: injector.get()));
}
