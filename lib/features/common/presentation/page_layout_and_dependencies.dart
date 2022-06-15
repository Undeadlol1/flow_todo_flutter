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
          appBar: AppBar(
            actions: [
              _buildPoints(),
              Avatar(),
              const SizedBox(width: 8),
            ],
          ),
          drawer: _Drawer(isHidden: isDrawerHidden),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  child,
                  const ListenerThatRunsFunctionsWithBuildContext(),
                ],
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
  final bool? isHidden;
  const _Drawer({Key? key, this.isHidden}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isHidden == null || isHidden == true) {
      return const SizedBox();
    }

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
