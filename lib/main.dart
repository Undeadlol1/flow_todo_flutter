import 'dart:async';
import 'dart:math';
import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/experience_to_next_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/experience_progress_bar.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/create_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/delete_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/get_tasks_to_do_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/data/update_task_repository.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/services/stale_task_detector.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/create_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/delete_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/get_tasks_to_do.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_creation.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/make_step_forward_on_the_task.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentification/domain/entities/user.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'firebase_options.dart';

import 'features/pages/presentation/main_page.dart';

final _tasksCubit = TasksCubit();
final _profileCubit = ProfileCubit();
final _authentificationCubit = AuthentificationCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  _setUpDI();

  runApp(const MyApp());
}

_setUpDI() {
  final injector = GetIt.I;

  injector.registerSingleton(_tasksCubit);
  injector.registerSingleton(_profileCubit);
  injector.registerSingleton(FirebaseFirestore.instance);
  injector.registerSingleton(BuildContextProvider());
  injector.registerSingleton(UniqueIdGenerator());
  injector.registerSingleton(GetTodaysDate());
  injector.registerSingleton(const ExperienceToNextLevelCalculator());
  injector.registerSingleton(UserLevelCalculator(
    pointsToNextLevelCalculator: injector.get(),
  ));
  injector.registerSingleton(NextRepetitionCalculator());
  injector.registerSingleton(GoToMainPage(contextProvider: injector.get()));
  injector.registerSingleton(GoToTaskPage(contextProvider: injector.get()));
  injector.registerSingleton(GoToTaskCreation(contextProvider: injector.get()));
  injector.registerSingleton(CreateTaskRepository(firestore: injector.get()));
  injector.registerSingleton(UpdateTaskRepository(firestore: injector.get()));
  injector.registerSingleton(DeleteTaskRepository(firestore: injector.get()));
  injector.registerSingleton(GetTasksToDoRepository(firestore: injector.get()));
  injector
      .registerSingleton(UpdateProfileRepository(firestore: injector.get()));
  injector.registerSingleton(
    AddPointsToViewer(
      profileCubit: injector.get(),
      updateProfileRepository: injector.get(),
    ),
  );
  injector.registerSingleton(
    MakeStepForwardOnTheTask(
      tasksCubit: injector.get(),
      goToMainPage: injector.get(),
      addPointsToViewer: injector.get(),
      updateTaskRepository: injector.get(),
      nextRepetitionCalculator: injector.get(),
    ),
  );
  injector.registerSingleton(const GetTasksToDo());
  injector.registerSingleton(StaleTaskDetector());
  injector.registerSingleton(GetProfileRepository(firestore: injector.get()));
  injector.registerSingleton(GetProfile(
    profileCubit: injector.get(),
    getProfileRepository: injector.get(),
  ));
  injector.registerSingleton(CreateTask(
    tasksCubit: injector.get(),
    profileCubit: injector.get(),
    getTodaysDate: injector.get(),
    addPointsToUser: injector.get(),
    uniqueIdGenerator: injector.get(),
    createTaskRepository: injector.get(),
  ));
  injector.registerSingleton(DeleteTask(
    tasksCubit: injector.get(),
    goToMainPage: injector.get(),
    addPointsToUser: injector.get(),
    deleteTaskRepository: injector.get(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _theme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.blue,
      secondary: Colors.lightBlue,
    ),
  );
  final _darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
  );

  @override
  void initState() {
    super.initState();

    Future.microtask(_syncFirebaseAuthWithAuthenticationCubit);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _tasksCubit),
            BlocProvider(create: (context) => _profileCubit),
            BlocProvider(create: (context) => _authentificationCubit),
          ],
          child: MaterialApp(
            title: 'Flow TODO',
            theme: _theme,
            darkTheme: _darkTheme,
            initialRoute: MainPage.pathName,
            routes: {
              MainPage.pathName: (contex) => const MainPage(),
              TaskPage.pathName: (contex) => const TaskPage(),
              WorkOnTaskPage.pathName: (contex) => const WorkOnTaskPage(),
            },
          ),
        ),
        const ExperienceProgressBar(percentage: 0.5),
      ],
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
            avatar: event.photoURL,
            email: event.email ?? '',
            displayName: event.displayName ?? '',
          ),
        );
      }
    });
  }
}
