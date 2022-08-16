import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/DI/configure_automatic_di.dart';
import 'core/DI/configure_manual_di.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBlocOverrides.runZoned(
    () async {
      _configureDeviceOrientation();

      await _configureFirebase();

      _configureCrashlytics();

      _configureDI();
    },
    createStorage: () async {
      return HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getTemporaryDirectory(),
      );
    },
  );
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
  }
}
