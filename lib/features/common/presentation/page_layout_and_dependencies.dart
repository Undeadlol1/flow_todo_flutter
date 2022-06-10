import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flow_todo_flutter_2022/features/tasks/domain/use_cases/go_to_task_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

class PageLayoutAndDependencies extends StatelessWidget {
  final Widget child;
  final bool? isDrawerHidden;
  const PageLayoutAndDependencies({
    Key? key,
    required this.child,
    this.isDrawerHidden = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, authentication) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                if (authentication is Authenticated &&
                    authentication.user.avatar != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(authentication.user.avatar!),
                  ),
                const SizedBox(width: 8),
              ],
            ),
            drawer: isDrawerHidden != null && isDrawerHidden!
                ? null
                : const _Drawer(),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  child,
                  const ListenerThatRunsFunctionsWithBuildContext(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => GetIt.I<GoToTaskCreation>()(),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, authentication) {
        return Drawer(
          child: Column(
            children: [
              if (authentication is Authenticated)
                const SignOutButton()
              else
                const SizedBox(
                  height: 300,
                  child: SignInScreen(),
                ),
            ],
          ),
        );
      },
    );
  }
}
