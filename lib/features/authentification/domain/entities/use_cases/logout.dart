import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/cubit/profile_cubit.dart';

class Logout {
  final TasksCubit tasksCubit;
  final ProfileCubit profileCubit;
  final FirebaseAuth firebaseAuth;
  final AuthentificationCubit authentificationCubit;

  const Logout({
    required this.tasksCubit,
    required this.profileCubit,
    required this.firebaseAuth,
    required this.authentificationCubit,
  });

  Future<void> call() async {
    tasksCubit.updateList([]);
    profileCubit.setProfileNotFoundOrUnloaded();
    authentificationCubit.setNotAuthenticated();
    await firebaseAuth.signOut();
  }
}
