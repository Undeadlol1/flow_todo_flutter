import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
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
      await _setupFirebase();

      configureManualDI();

      configureAutomaticDI();

      runApp(const App());
    },
    blocObserver: _GlobalBlocObserver(),
    createStorage: () async {
      return HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getTemporaryDirectory(),
      );
    },
  );
}

Future<void> _setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  FlutterFireUIAuth.configureProviders([
    const GoogleProviderConfiguration(
      clientId:
          '772125171665-ci6st9nbunsrvhv6jdb0e2avmkto9vod.apps.googleusercontent.com',
    ),
  ]);
}

class _GlobalBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print('onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- ${bloc.runtimeType}, $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('onClose -- ${bloc.runtimeType}');
    }
  }
}
