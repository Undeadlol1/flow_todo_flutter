// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAmCyhaB-8xjMH5yi9PoitoAyD-KeFnNtA',
    appId: '1:772125171665:web:3fffadc4031335de290af0',
    messagingSenderId: '772125171665',
    projectId: 'flow-todo-5824b',
    authDomain: 'flow-todo-5824b.firebaseapp.com',
    databaseURL: 'https://flow-todo-5824b.firebaseio.com',
    storageBucket: 'flow-todo-5824b.appspot.com',
    measurementId: 'G-DLFD2VSSK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHoKfqO0GCnPH2KmmYP2vGr3uxVx7JzGE',
    appId: '1:772125171665:android:6e35fa5cb043e46a290af0',
    messagingSenderId: '772125171665',
    projectId: 'flow-todo-5824b',
    databaseURL: 'https://flow-todo-5824b.firebaseio.com',
    storageBucket: 'flow-todo-5824b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBma6mtpNrBNgoPOZL4fiybKE8fV6PBoLI',
    appId: '1:772125171665:ios:3c284d04067ef699290af0',
    messagingSenderId: '772125171665',
    projectId: 'flow-todo-5824b',
    databaseURL: 'https://flow-todo-5824b.firebaseio.com',
    storageBucket: 'flow-todo-5824b.appspot.com',
    iosClientId: '772125171665-ah47hpqle0gs3kj4redianlb7kdc1ps9.apps.googleusercontent.com',
    iosBundleId: 'com.example.flowTodoFlutter2022',
  );
}