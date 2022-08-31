import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_todo_flutter_2022/core/remote_config/cubit/remote_config_cubit.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tags_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_worked_on_today_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class Logout {
  final TagsCubit tagsCubit;
  final TasksCubit tasksCubit;
  final ProfileCubit profileCubit;
  final FirebaseAuth firebaseAuth;
  final RemoteConfigCubit remoteConfigCubit;
  final FirebaseFirestore firebaseFirestore;
  final TasksWorkedOnTodayCubit tasksDoneTodayCubit;
  final AuthentificationCubit authentificationCubit;

  const Logout({
    required this.tagsCubit,
    required this.tasksCubit,
    required this.profileCubit,
    required this.firebaseAuth,
    required this.remoteConfigCubit,
    required this.firebaseFirestore,
    required this.tasksDoneTodayCubit,
    required this.authentificationCubit,
  });

  Future<void> call() async {
    tagsCubit.update({});
    remoteConfigCubit.reset();
    tasksCubit.updateList([]);
    tasksDoneTodayCubit.update([]);
    profileCubit.setProfileNotFoundOrUnloaded();
    authentificationCubit.setNotAuthenticated();

    await firebaseAuth.signOut();

    await HydratedBlocOverrides.current?.storage.clear();
  }
}
