import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/DI/configure_automatic_di.dart';
import 'core/DI/configure_manual_di.dart';
import 'core/presentation/app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupFirebase();

  configureManualDI();

  configureAutomaticDI();

  final storageDirectory = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getTemporaryDirectory();

  // Hive.init();
  await Hive.initFlutter();
  // await Hive.openBox('ProfileCubit');
  // Hive.box('ProfileCubit').add(null);

  final storage = await HydratedStorage.build(
    storageDirectory: storageDirectory,
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      const App(),
    ),
    storage: storage,
  );

  // final storage = await HydratedStorage.build(
  //   storageDirectory: storageDirectory,
  // );

  //   HydratedBlocOverrides.runZoned(
  //   () => runApp(MyApp(
  //   )),
  //   storage: storage,
  // );

  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   storage: await createStorage(),
  // );
  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   storage: storage,
  // );
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
