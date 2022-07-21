import 'package:build_context_provider/build_context_provider.dart';
import 'package:flow_todo_flutter_2022/features/authentification/presentation/widgets/google_sign_in_button.dart';
import 'package:flow_todo_flutter_2022/features/common/presentation/widgets/animated_numbers.dart';
import 'package:flow_todo_flutter_2022/features/leveling/domain/services/user_level_calculator.dart';
import 'package:flow_todo_flutter_2022/features/users/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/auth.dart' show SignOutButton;
import 'package:get_it/get_it.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../authentification/presentation/cubit/authentification_cubit.dart';
import '../../users/presentation/cubit/profile_cubit.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final bool isDrawerHidden;
  final bool isAppBarHidden;
  final Widget? floatingActionButton;
  final bool isNumbersAnimationSuspended;
  const PageLayout({
    Key? key,
    required this.child,
    this.floatingActionButton,
    this.isDrawerHidden = true,
    this.isAppBarHidden = false,
    this.isNumbersAnimationSuspended = true,
  }) : super(key: key);

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
                resizeToAvoidBottomInset: true,
                drawer: isDrawerHidden == true ? null : const _Drawer(),
                appBar: isAppBarHidden
                    ? null
                    : AppBar(
                        actions: [
                          _UserLevel(
                            isNumbersAnimationSuspended:
                                isNumbersAnimationSuspended,
                          ),
                          const Padding(
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
                    padding: const EdgeInsets.only(
                      top: 6,
                      left: 6,
                      right: 6,
                      bottom: 12.0,
                    ),
                    child: child,
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: floatingActionButton,
                ),
                bottomNavigationBar: const _BottomNavigation(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _UserLevel extends StatelessWidget {
  final bool isNumbersAnimationSuspended;
  final UserLevelCalculator _userLevelCalculator = GetIt.I();
  _UserLevel({Key? key, required this.isNumbersAnimationSuspended})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoaded) {
          return Container(
            padding: const EdgeInsets.only(right: 7),
            child: Chip(
              label: Row(
                children: [
                  const Text('Level: '),
                  AnimatedNumbers(
                    number: _userLevelCalculator(
                      profileState.profile?.experience ?? 0,
                    ).value,
                    areNumberAnimationsSuspended: isNumbersAnimationSuspended,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // ignore: dead_code
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: WaterDropNavBar(
        waterDropColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onItemSelected: (index) {
          // setState(() {
          //   selectedIndex = index;
          // });
          // pageController.animateToPage(selectedIndex,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeOutQuad);
        },
        // selectedIndex: selectedIndex,
        selectedIndex: 1,
        barItems: [
          BarItem(
            filledIcon: Icons.bookmark_rounded,
            outlinedIcon: Icons.bookmark_border_rounded,
          ),
          BarItem(
            filledIcon: Icons.favorite_rounded,
            outlinedIcon: Icons.favorite_border_rounded,
          ),
        ],
      ),
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
                  GoogleSignInButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
