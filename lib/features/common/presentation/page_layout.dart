import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../users/presentation/cubit/profile_cubit.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final bool isAppBarHidden;
  final Widget? floatingActionButton;
  final bool isNumbersAnimationSuspended;
  const PageLayout({
    Key? key,
    required this.child,
    this.floatingActionButton,
    this.isAppBarHidden = false,
    this.isNumbersAnimationSuspended = true,
  }) : super(key: key);

  static const _padding = EdgeInsets.only(
    top: 6,
    left: 6,
    right: 6,
    bottom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: BlocBuilder<AuthentificationCubit, AuthentificationState>(
        builder: (BuildContext context, authentication) {
          return Stack(
            children: [
              const ListenerThatRunsFunctionsWithBuildContext(),
              Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: isAppBarHidden
                    ? null
                    : AppBar(
                        actions: const [
                          _UserLevelBadge(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Avatar(
                                radius: 16,
                                isLevelHidden: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                body: SafeArea(
                  child: Padding(
                    padding: _padding,
                    child: child,
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: floatingActionButton,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _UserLevelBadge extends StatelessWidget {
  static final UserLevelCalculator _userLevelCalculator = GetIt.I();
  const _UserLevelBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, int>(
      selector: (state) => state.profile.experience,
      builder: (_, experience) {
        final level = _userLevelCalculator(experience).value.toString();
        return Container(
          padding: const EdgeInsets.only(right: 7),
          child: Chip(
            label: Text('Level: $level'),
          ),
        );
      },
    );
  }
}
