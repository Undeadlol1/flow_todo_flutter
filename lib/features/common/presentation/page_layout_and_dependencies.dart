import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/cubit/authentification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageLayoutAndDependencies extends StatelessWidget {
  final Widget child;
  const PageLayoutAndDependencies({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthentificationCubit, AuthentificationState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state is Authenticated && state.user.avatar != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(state.user.avatar!),
                ),
              const SizedBox(width: 8)
            ],
          ),
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
        );
      },
    );
  }
}
