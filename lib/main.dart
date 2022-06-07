import 'dart:async';
import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentification/domain/entities/user.dart';
import 'firebase_options.dart';

import 'features/pages/presentation/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterFireUIAuth.configureProviders([
    const GoogleProviderConfiguration(
      clientId: '772125171665-ci6st9nbunsrvhv6jdb0e2avmkto9vod.apps.googleusercontent.com',
    ),
  ]);

  _setUpDI();

  runApp(const MyApp());
}

_setUpDI() {
  final injector = GetIt.I;
  GetIt.I.registerSingleton(BuildContextProvider());
  GetIt.I.registerSingleton(FirebaseFirestore.instance);
  GetIt.I.registerSingleton(GetTasksToDo(firestore: injector.get()));
  GetIt.I.registerSingleton(GoToTaskPage(contextProvider: injector.get()));
}

final _authentificationCubit = AuthentificationCubit();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.microtask(_syncFirebaseAuthWithAuthenticationCubit);
  }

  @override
  Widget build(BuildContext context) {
    var taskFixture = Task(
      id: 'id',
      title: 'title',
      dueAt: 0,
      isDone: false,
      userId: 'userId',
      createdAt: 0,
    );

    return BlocProvider(
      create: (context) {
        return _authentificationCubit;
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        initialRoute: MainPage.pathName,
        routes: {
          '/': (contex) => const Scaffold(body: MainPage()),
          '/task': (contex) => TaskPage(task: taskFixture),
          WorkOnTaskPage.pathName: (contex) => const WorkOnTaskPage(),
        },
      ),
    );
  }

  FutureOr<void> _syncFirebaseAuthWithAuthenticationCubit() {
    firebase_auth.FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        _authentificationCubit.setNotAuthenticated();
      } else {
        _authentificationCubit.setUser(
          User(
            id: event.uid,
            email: event.email ?? '',
            displayName: event.displayName ?? '',
          ),
        );
      }
    });
  }
}
