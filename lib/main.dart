import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/auth.dart';

import 'core/DI/configure_automatic_di.dart';
import 'core/DI/configure_manual_di.dart';
import 'core/presentation/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _configureDeviceOrientation();

  await _configureFirebase();

  configureManualDI();

  configureAutomaticDI();

  runApp(const App());
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

  FlutterFireUIAuth.configureProviders([
    const GoogleProviderConfiguration(
      clientId:
          '772125171665-ci6st9nbunsrvhv6jdb0e2avmkto9vod.apps.googleusercontent.com',
    ),
  ]);
}
