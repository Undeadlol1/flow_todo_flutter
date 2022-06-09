import 'package:firebase_auth/firebase_auth.dart' as auth_lib;
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

class AuthentificationListener extends StatelessWidget {
  const AuthentificationListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth_lib.FirebaseAuth.instance.authStateChanges(),
      builder: ((context, AsyncSnapshot<auth_lib.User?> snapshot) {
        final authCubit = context.read<AuthentificationCubit>();

        if (snapshot.connectionState != ConnectionState.active) {
          return Container();
        }

        if (snapshot.hasData) {
          authCubit.setUser(
            User(
              id: snapshot.data?.uid ?? '',
              email: snapshot.data?.email ?? '',
              avatar: snapshot.data?.photoURL ?? '',
              displayName: snapshot.data?.displayName ?? '',
            ),
          );
        } else {
          authCubit.setNotAuthenticated();
        }
        return Container();
      }),
    );
  }
}
