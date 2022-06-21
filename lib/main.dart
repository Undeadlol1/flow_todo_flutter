import 'dart:async';

import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/logout.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/common/services/get_todays_date.dart';
import 'package:flow_todo_flutter_2022/features/common/services/snackbar_service.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/default_leveling_config.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
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
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/update_task_note.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flow_todo_flutter_2022/features/users/data/get_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/data/update_profile_repository.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

import 'features/authentification/domain/entities/user.dart';
import 'features/leveling/domain/services/experience_to_reach_next_level_calculator.dart';
import 'features/pages/presentation/main_page.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'firebase_options.dart';

final _tasksCubit = TasksCubit();
final _profileCubit = ProfileCubit();
final _tasksDoneTodayCubit = TasksDoneTodayCubit();
final _authentificationCubit = AuthentificationCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupFirebase();

  _setupDI();

  runApp(const MyApp());
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

_setupDI() {
  final injector = GetIt.I;

  injector.registerSingleton(_tasksCubit);
  injector.registerSingleton(_profileCubit);
  injector.registerSingleton(_tasksDoneTodayCubit);
  injector.registerSingleton(_authentificationCubit);
  injector.registerFactory(() => FirebaseFirestore.instance);
  injector.registerFactory(() => firebase_auth.FirebaseAuth.instance);
  injector.registerSingleton(BuildContextProvider());
  injector.registerSingleton(UniqueIdGenerator());
  injector.registerSingleton(GetTodaysDate());
  injector
      .registerSingleton(SnackbarService(buildContextProvider: injector.get()));
  injector.registerSingleton(
    ExperienceToReachNextLevelCalculator(
      levelingConfig: DefaultLevelingConfig(),
    ),
  );
  injector.registerSingleton(
    UserLevelCalculator(
      experienceToReachALevelCalculator: injector.get(),
    ),
  );
  injector.registerSingleton(
    LevelProgressPercentageCalculator(
      userLevelCalculator: injector.get(),
      experienceToReachALevelCalculator: injector.get(),
    ),
  );
  injector.registerSingleton(NextRepetitionCalculator());
  injector.registerSingleton(GoToMainPage(contextProvider: injector.get()));
  injector.registerSingleton(GoToTaskPage(contextProvider: injector.get()));
  injector.registerSingleton(GoToTaskCreation(contextProvider: injector.get()));
  injector.registerSingleton(CreateTaskRepository(firestore: injector.get()));
  injector
      .registerFactory(() => UpdateTaskRepository(firestore: injector.get()));
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
  injector.registerFactory(
    () => MakeStepForwardOnTheTask(
      tasksCubit: injector.get(),
      goToMainPage: injector.get(),
      snackbarService: injector.get(),
      addPointsToViewer: injector.get(),
      tasksDoneTodayCubit: injector.get(),
      updateTaskRepository: injector.get(),
      nextRepetitionCalculator: injector.get(),
    ),
  );
  injector.registerSingleton(
    UpdateTaskNote(
      tasksCubit: injector.get(),
      updateTaskRepository: injector.get(),
    ),
  );
  injector.registerSingleton(SignInWithGoogle(firebaseAuth: injector.get()));
  injector.registerSingleton(
    Logout(
      tasksCubit: injector.get(),
      profileCubit: injector.get(),
      firebaseAuth: injector.get(),
      authentificationCubit: injector.get(),
    ),
  );
  injector.registerSingleton(const GetTasksToDo());
  injector.registerSingleton(StaleTaskDetector());
  injector.registerSingleton(GetProfileRepository(firestore: injector.get()));
  injector.registerSingleton(
    GetProfile(
      profileCubit: injector.get(),
      getProfileRepository: injector.get(),
    ),
  );
  injector.registerSingleton(
    CreateTask(
      tasksCubit: injector.get(),
      profileCubit: injector.get(),
      getTodaysDate: injector.get(),
      addPointsToUser: injector.get(),
      uniqueIdGenerator: injector.get(),
      createTaskRepository: injector.get(),
    ),
  );
  injector.registerSingleton(
    DeleteTask(
      tasksCubit: injector.get(),
      goToMainPage: injector.get(),
      addPointsToUser: injector.get(),
      deleteTaskRepository: injector.get(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription authStream;

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
    authStream = GetIt.I<firebase_auth.FirebaseAuth>()
        .userChanges()
        .listen(_syncFirebaseAuthWithAuthenticationCubit);
  }

  @override
  void dispose() async {
    await authStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _tasksCubit),
        BlocProvider(create: (context) => _profileCubit),
        BlocProvider(create: (context) => _tasksDoneTodayCubit),
        BlocProvider(create: (context) => _authentificationCubit),
      ],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MaterialApp(
            theme: _theme,
            title: 'Flow TODO',
            darkTheme: _darkTheme,
            initialRoute: MainPage.pathName,
            routes: {
              MainPage.pathName: (contex) => const MainPage(),
              TaskPage.pathName: (contex) => const TaskPage(),
              ProfilePage.pathName: (contex) => const ProfilePage(),
              WorkOnTaskPage.pathName: (contex) => const WorkOnTaskPage(),
            },
          ),
          const ExperienceProgressBar(),
        ],
      ),
    );
  }

  void _syncFirebaseAuthWithAuthenticationCubit(firebase_auth.User? user) {
    if (user == null) {
      _tasksCubit.updateList([]);
      _profileCubit.setProfileNotFoundOrUnloaded();
      _authentificationCubit.setNotAuthenticated();
    } else {
      _authentificationCubit.setUser(
        User(
          id: user.uid,
          avatar: user.photoURL,
          email: user.email ?? '',
          displayName: user.displayName ?? '',
        ),
      );
    }
  }
}
