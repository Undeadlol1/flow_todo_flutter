import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get_it/get_it.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../tasks/domain/use_cases/go_to_task_creation.dart';
import '../../users/presentation/cubit/profile_cubit.dart';
import '../../users/presentation/widgets/avatar.dart';

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
        return Scaffold(
          resizeToAvoidBottomInset: true,
          drawer: isDrawerHidden == true ? null : const _Drawer(),
          appBar: AppBar(
            actions: [
              _buildPoints(),
              Avatar(),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child,
                    const ListenerThatRunsFunctionsWithBuildContext(),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => GetIt.I<GoToTaskCreation>()(),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildPoints() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          return Container(
            padding: const EdgeInsets.all(20),
            // child: Text('Points: ${profileState.profile.points.toString()}'),
            child: Text('Points: ${profileState.profile.points.toString()}'),
          );
        }
        return Container();
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        );
      },
    );
  }
}
