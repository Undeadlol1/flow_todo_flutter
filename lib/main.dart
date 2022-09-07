import 'dart:async';
import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/DI/configure_automatic_di.dart';
import 'core/DI/configure_manual_di.dart';
import 'core/presentation/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBlocOverrides.runZoned(
    () async {
      debugRepaintRainbowEnabled = kDebugMode;

      _configureDeviceOrientation();

      await _configureFirebase();

      _configureCrashlytics();

      _configurePerformanceMonitoring();

      _configureDI();

      _configureRemoteConfig();

      runApp(const App());
    },
    createStorage: _createStateStorage,
  );
}

Future<void> _configureRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval:
          kReleaseMode ? const Duration(hours: 3) : const Duration(minutes: 10),
    ),
  );

  await remoteConfig.setDefaults(const {
    "are_tags_enabled": true,
    "are_goals_enabled": false,
    "are_quests_enabled": false,
    "is_only_single_selected_task_allowed": true,
    "is_tasks_list_separator_color_random": false,
  });
}

_configureDI() {
  configureManualDI();

  configureAutomaticDI();
}

void _configureDeviceOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> _configureFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAnalytics.instance.app
      .setAutomaticDataCollectionEnabled(kReleaseMode);
}

void _configureCrashlytics() {
  if (kReleaseMode) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // https://firebase.google.com/docs/crashlytics/customize-crash-reports?platform=flutter#errors-outside-flutter
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
          fatal: true,
        );
      }).sendPort,
    );
  }
}

void _configurePerformanceMonitoring() {
  FirebasePerformance.instance.setPerformanceCollectionEnabled(kReleaseMode);
}

FutureOr<Storage> _createStateStorage() async {
  return HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
}
