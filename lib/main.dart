import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_todo_flutter_2022/core/configure_automatic_di.dart';
import 'package:flow_todo_flutter_2022/core/configure_manual_di.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/leveling/presentation/widgets/experience_progress_bar.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_done_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/task_page.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/pages/work_on_task_page.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'features/authentification/domain/entities/user.dart';
import 'features/pages/presentation/main_page.dart';
import 'features/tasks/presentation/cubit/tasks_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupFirebase();

  configureManualDI();

  configureAutomaticDI();

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
