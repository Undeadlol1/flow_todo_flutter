import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart';

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
            appBar: _AppBar(),
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
              onPressed: () {},
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

class _AppBar extends AppBar {
  _AppBar({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, authentication) {
        return AppBar(
          actions: [
            if (authentication is Authenticated &&
                authentication.user.avatar != null)
              CircleAvatar(
                backgroundImage: NetworkImage(authentication.user.avatar!),
              ),
            const SizedBox(width: 8),
          ],
        );
      },
    );
  }
}
