import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      _configureDeviceOrientation();

      await _configureFirebase();

      configureManualDI();

      configureAutomaticDI();

      runApp(const App());
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

  FirebaseAnalytics.instance.app
      .setAutomaticDataCollectionEnabled(kReleaseMode);
}
