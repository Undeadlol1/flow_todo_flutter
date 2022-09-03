import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/common/domain/use_cases/go_to_main_page.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:flow_todo_flutter_2022/features/goals/presentation/pages/goals_page.dart';
import 'package:flow_todo_flutter_2022/features/quests/presentation/cubits/active_quests_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/filtered_tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/filter_tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';

import 'pages/main_page.dart';
import '../../features/authentification/domain/entities/user.dart';
import '../../features/authentification/presentation/cubit/authentification_cubit.dart';
import '../../features/leveling/presentation/widgets/experience_progress_bar.dart';
import '../../features/tasks/presentation/cubit/tasks_cubit.dart';
import '../../features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import '../../features/tasks/presentation/pages/task_page.dart';
import '../../features/tasks/presentation/pages/work_on_task_page.dart';
import '../../features/users/presentation/cubit/profile_cubit.dart';
import '../../features/users/presentation/pages/profile_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static final FirebaseAnalyticsObserver _firebaseAnalyticsObserver =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  final TagsCubit tagsCubit = GetIt.I();
  final TasksCubit tasksCubit = GetIt.I();
  final GoalsCubit goalsCubit = GetIt.I();
  final ProfileCubit profileCubit = GetIt.I();
  final RemoteConfigCubit remoteConfigCubit = GetIt.I();
  final ActiveQuestsCubit activeQuestsCubit = GetIt.I();
  final FilteredTasksCubit filteredTasksCubit = GetIt.I();
  final TasksWorkedOnTodayCubit tasksDoneTodayCubit = GetIt.I();
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
    firebaseAuthStream =
        GetIt.I<firebase_auth.FirebaseAuth>().userChanges().listen(
      (user) {
        if (user == null) GetIt.I<GoToMainPage>()();
        _syncFirebaseAuthWithAuthenticationCubit(user);
      },
    );
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => tagsCubit),
          BlocProvider(create: (_) => tasksCubit),
          BlocProvider(create: (_) => goalsCubit),
          BlocProvider(create: (_) => profileCubit),
          BlocProvider(create: (_) => remoteConfigCubit),
          BlocProvider(create: (_) => activeQuestsCubit),
          BlocProvider(create: (_) => filteredTasksCubit),
          BlocProvider(create: (_) => tasksDoneTodayCubit),
          BlocProvider(create: (_) => authentificationCubit),
        ],
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MaterialApp(
              theme: lightTheme,
              title: 'Flow TODO',
              darkTheme: darkTheme,
              initialRoute: MainPage.pathName,
              navigatorObservers: [_firebaseAnalyticsObserver],
              routes: {
                MainPage.pathName: (contex) => const MainPage(),
                GoalsPage.pathName: (contex) => const GoalsPage(),
                ProfilePage.pathName: (contex) => const ProfilePage(),
                TaskPage.pathName: (contex) => const TaskPage(),
                WorkOnTaskPage.pathName: (contex) => const WorkOnTaskPage(),
                FilterTasksPage.pathName: (contex) => const FilterTasksPage(),
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
    );
  }

  void _syncFirebaseAuthWithAuthenticationCubit(firebase_auth.User? user) {
    log('user: ${user?.email.toString()}');
    if (user == null) {
      tagsCubit.update({});
      goalsCubit.update([]);
      tasksCubit.updateList([]);
      remoteConfigCubit.reset();
      profileCubit.setProfileNotFoundOrUnloaded();
      authentificationCubit.setNotAuthenticated();
    } else {
      authentificationCubit.setUser(
        User(
          id: user.uid,
          email: user.email ?? '',
          avatar: user.photoURL ?? user.providerData.first.photoURL ?? '',
          displayName:
              user.displayName ?? user.providerData.first.displayName ?? '',
        ),
      );
    }
  }
}
