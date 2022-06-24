import 'dart:async';

import 'package:build_context_provider/build_context_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_todo_flutter_2022/core/configure_automatic_di.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/logout.dart';
import 'package:flow_todo_flutter_2022/features/authentification/domain/entities/use_cases/sign_in_with_google.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/common/services/unique_id_generator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/entities/default_leveling_config.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/level_progress_percentage_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/experience_progress_bar.dart';
import 'package:flow_todo_flutter_2022/features/spaced_repetition/domain/services/next_repetition_calculator.dart';
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
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/add_points_to_viewer.dart';
import 'package:flow_todo_flutter_2022/features/users/domain/use_cases/get_profile.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/pages/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:fps_widget/fps_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'features/authentification/domain/entities/user.dart';
import 'features/leveling/domain/services/experience_to_reach_next_level_calculator.dart';
import 'features/pages/presentation/main_page.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupFirebase();

  configureAutomaticDI();

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

  injector.registerFactory(() => FirebaseFirestore.instance);
  injector.registerFactory(() => firebase_auth.FirebaseAuth.instance);
  injector.registerSingleton(BuildContextProvider());
  injector.registerSingleton(UniqueIdGenerator());
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
      getTodaysDate: injector.get(),
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
  final TasksCubit tasksCubit = GetIt.I();
  final ProfileCubit profileCubit = GetIt.I();
  final TasksDoneTodayCubit tasksDoneTodayCubit = GetIt.I();
  final AuthentificationCubit authentificationCubit = GetIt.I();

  final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.95,
    appBarElevation: 1.5,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
      navigationBarIndicatorOpacity: 1.00,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
  final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.blue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
      navigationBarIndicatorOpacity: 1.00,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  late final StreamSubscription firebaseAuthStream;

  @override
  void initState() {
    super.initState();
    firebaseAuthStream = GetIt.I<firebase_auth.FirebaseAuth>()
        .userChanges()
        .listen(_syncFirebaseAuthWithAuthenticationCubit);
  }

  @override
  void dispose() async {
    await firebaseAuthStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FPSWidget(
        show: kDebugMode,
        alignment: Alignment.bottomLeft,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => tasksCubit),
            BlocProvider(create: (context) => profileCubit),
            BlocProvider(create: (context) => tasksDoneTodayCubit),
            BlocProvider(create: (context) => authentificationCubit),
          ],
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              MaterialApp(
                theme: lightTheme,
                title: 'Flow TODO',
                darkTheme: darkTheme,
                initialRoute: MainPage.pathName,
                routes: {
                  MainPage.pathName: (contex) => const MainPage(),
                  TaskPage.pathName: (contex) => const TaskPage(),
                  ProfilePage.pathName: (contex) => const ProfilePage(),
                  WorkOnTaskPage.pathName: (contex) => const WorkOnTaskPage(),
                },
              ),
              ExperienceProgressBar(
                themeData:
                    MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                                .platformBrightness ==
                            Brightness.light
                        ? lightTheme
                        : darkTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _syncFirebaseAuthWithAuthenticationCubit(firebase_auth.User? user) {
    if (user == null) {
      tasksCubit.updateList([]);
      profileCubit.setProfileNotFoundOrUnloaded();
      authentificationCubit.setNotAuthenticated();
    } else {
      authentificationCubit.setUser(
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
